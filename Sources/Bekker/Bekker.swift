import ArgumentParser
import Combine
import Foundation

var cancellable: AnyCancellable?

struct Bekker: ParsableCommand {
	static let configuration = CommandConfiguration(
		abstract: "Reads an Aristotelian work’s XML file from Perseus, and dumps it to the standard output in a Roam-Research-friendly format."
	)

	@Option(name: .shortAndLong, help: "An Aristotelian work’s XML file, downloaded from Perseus.")
	var input: String

	@Option(name: .shortAndLong, help: "Path to a `beta2uni` binary.")
	var path: String = "/usr/local/bin/beta2uni"

	@Option(name: .shortAndLong, help: "An abbreviation to use for the book. If absent, it will use the input XML file’s basename.")
	var abbreviation: String?

	mutating func run() throws {
		let url = URL(fileURLWithPath: input)
		guard let parser = Parser(contentsOf: url) else { return }

		let s = self
		let abbr = abbreviation ?? url.deletingPathExtension().lastPathComponent

		cancellable = parser.$lastUnit
			.compactMap { $0 }
			.map {
				Parser.Unit(
					text: try! Beta2Uni(beta: $0.text, path: s.path).run(),
					line: $0.line,
					page: $0.page,
					book: $0.book
				)
			}
			.sink {
				print("- [[\(abbr) \($0.book), \($0.page)\($0.line)]] \($0.text)")
			}

		parser.parse()
	}
}
