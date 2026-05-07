import Foundation

/// Client capabilities for the linked editing range feature.
///
/// - Since: 3.16.0
public typealias LinkedEditingRangeClientCapabilities = DynamicRegistrationClientCapabilities

/// Parameters for the `textDocument/linkedEditingRange` request.
///
/// - Since: 3.16.0
public struct LinkedEditingRangeParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?

	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier, position: Position
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.position = position
	}
}

/// The result of a linked editing range request.
///
/// - Since: 3.16.0
public struct LinkedEditingRanges: Codable, Sendable {
	/// A list of ranges that can be renamed together.
	public let ranges: [LSPRange]
	/// An optional word pattern to describe valid contents for the ranges.
	public let wordPattern: String?

	/// Creates an instance from its parts.
	public init(ranges: [LSPRange], wordPattern: String? = nil) {
		self.ranges = ranges
		self.wordPattern = wordPattern
	}
}

/// The response type for `textDocument/linkedEditingRange`.
public typealias LinkedEditingRangeResponse = LinkedEditingRanges?
