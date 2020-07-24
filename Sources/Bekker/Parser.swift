import Combine
import Foundation

/// `Parser` parses an XML file from Aristotle’s collection at Perseus and publishes its textual `Unit`s as a result.
class Parser: NSObject {
	/// A `Unit` is a piece of text that has been identified as belonging to a certain book, page and line in Bekker’s numbering scheme.
	struct Unit {
		let text: String
		let line: String
		let page: String
		let book: String
	}

	/// The last parsed `Unit`
	@Published var lastUnit: Unit?

	/// An instance of `XMLParser`.
	let xmlParser: XMLParser

	private var lastBook: String?

	private var lastPage: String?

	private var lastLine: String?

	private var currentText: String = ""

	/// Creates an instance of the parser.
	/// - Parameter xmlParser: An instance of `XMLParser`.
	init(xmlParser: XMLParser) {
		self.xmlParser = xmlParser
		super.init()
		xmlParser.delegate = self
	}

	/// Creates an instance of the parser and prepares it for parsing the XML file at the specified URL.
	/// - Parameter url: The URL of the XML file to parse.
	convenience init?(contentsOf url: URL) {
		guard let xmlParser = XMLParser(contentsOf: url) else {
			return nil
		}
		self.init(xmlParser: xmlParser)
	}

	/// Begins the parsing process.
	func parse() {
		xmlParser.parse()
	}

	private func pluckOut() {
		guard !currentText.isEmpty, let book = lastBook, let page = lastPage, let line = lastLine else { return }
		lastUnit = Unit(text: currentText, line: line, page: page, book: book)
		currentText = ""
	}
}

extension Parser: XMLParserDelegate {
	func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String: String] = [:]) {
		switch elementName {
		case "div1":
			guard let type = attributeDict["type"], type == "Book", let book = attributeDict["n"] else { return }
			pluckOut()
			lastBook = book
		case "milestone":
			guard let unit = attributeDict["unit"], let n = attributeDict["n"] else { return }
			switch unit {
			case "bekker page", "section":
				pluckOut()
				lastPage = n
			case "bekker line", "line":
				pluckOut()
				lastLine = n
			default:
				break
			}
		default:
			break
		}
	}

	func parser(_ parser: XMLParser, foundCharacters string: String) {
		guard !string.hasPrefix("Book"), lastBook != nil, lastPage != nil, lastLine != nil else { return }
		let s = string.trimmingCharacters(in: .whitespacesAndNewlines)
		currentText.append(s)
	}

	func parserDidEndDocument(_ parser: XMLParser) {
		pluckOut()
	}
}
