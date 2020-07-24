import Foundation

internal enum Beta2UniError: Error {
	case process(Error)
	case input(Error)
	case encoding
}

/// `Beta2Uni` encapsulates an execution of the `beta2uni` command.
internal class Beta2Uni {
	/// The path to the `beta2uni` binary
	let path: String

	/// The process that runs `beta2uni`
	let process: Process

	/// A `Pipe` to act as `stdin`
	let standardInput: Pipe

	/// A `Pipe` to act as `stdout`
	let standardOutput: Pipe

	/// The beta-encoded string to convert
	let beta: String

	/// Intializes an instance of `Beta2Uni`.
	/// - Parameters:
	///   - beta: The beta-encoded string to convert.
	///   - path: The path to the `beta2uni` binary.
	///   - process: The process that runs `beta2uni`.
	///   - standardInput: A `Pipe` to act as `stdin`.
	///   - standardOutput: A `Pipe` to act as `stdout`.
	init(beta: String, path: String, process: Process = Process(), standardInput: Pipe = Pipe(), standardOutput: Pipe = Pipe()) {
		self.process = process
		self.standardInput = standardInput
		self.standardOutput = standardOutput
		self.path = path
		self.beta = beta

		process.executableURL = URL(fileURLWithPath: path)
		process.standardInput = standardInput
		process.standardOutput = standardOutput
	}

	private func sendBetaAndClose() throws {
		standardInput.fileHandleForWriting.write(beta.data(using: .utf8)!)
		try standardInput.fileHandleForWriting.close()
	}

	private func readUnicode() throws -> String? {
		let data = standardOutput.fileHandleForReading.readDataToEndOfFile()
		guard let result = String(data: data, encoding: .utf8) else {
			throw Beta2UniError.encoding
		}
		return result
	}

	/// Runs `beta2uni` and generates an Unicode string from the instance’s `beta` string.
	/// - Throws:
	///     - `Beta2UniError.encoding` if the output string isn’t valid UTF-8.
	///     - `Beta2UniError.input` if the comand’s input can’t be read.
	///     - `Beta2UniError.process` if there’s an error running the `beta2uni` process.
	/// - Returns: An UTF-8 string equivalent to the instance’s `beta` string.
	func run() throws -> String {
		do {
			try process.run()
		} catch {
			throw Beta2UniError.process(error)
		}

		do {
			try sendBetaAndClose()
		} catch {
			throw Beta2UniError.input(error)
		}

		let result = try readUnicode()
		process.terminate()
		return result ?? ""
	}
}
