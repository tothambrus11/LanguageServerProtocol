import Foundation

/// Client capabilities for the `textDocument/formatting` request.
public typealias DocumentFormattingClientCapabilities = DynamicRegistrationClientCapabilities
/// Client capabilities for the `textDocument/rangeFormatting` request.
public typealias DocumentRangeFormattingClientCapabilities = DynamicRegistrationClientCapabilities

/// Value-object describing what formatting options are available.
public struct FormattingOptions: Codable, Hashable, Sendable {
	/// Size of a tab in spaces.
	public let tabSize: Int
	/// Prefer spaces over tabs.
	public let insertSpaces: Bool

	/// Creates an instance from its parts.
	public init(tabSize: Int, insertSpaces: Bool) {
		self.tabSize = tabSize
		self.insertSpaces = insertSpaces
	}
}

/// Parameters for the `textDocument/formatting` request.
public struct DocumentFormattingParams: Codable, Hashable, Sendable {
	/// The document to format.
	public let textDocument: TextDocumentIdentifier
	/// The format options.
	public let options: FormattingOptions

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, options: FormattingOptions) {
		self.textDocument = textDocument
		self.options = options
	}
}

/// Parameters for the `textDocument/rangeFormatting` request.
public struct DocumentRangeFormattingParams: Codable, Hashable, Sendable {
	/// The document to format.
	public let textDocument: TextDocumentIdentifier
	/// The range to format.
	public let range: LSPRange
	/// The format options.
	public let options: FormattingOptions

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, range: LSPRange, options: FormattingOptions) {
		self.textDocument = textDocument
		self.range = range
		self.options = options
	}
}

/// Parameters for the `textDocument/onTypeFormatting` request.
public struct DocumentOnTypeFormattingParams: Codable, Hashable, Sendable {
	/// The document to format.
	public let textDocument: TextDocumentIdentifier
	/// The position at which this request was sent.
	public let position: Position
	/// The character that has been typed.
	public let ch: String
	/// The format options.
	public let options: FormattingOptions

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, position: Position, ch: String,
		options: FormattingOptions
	) {
		self.textDocument = textDocument
		self.position = position
		self.ch = ch
		self.options = options
	}
}

/// The response type for formatting requests.
public typealias FormattingResult = [TextEdit]?
