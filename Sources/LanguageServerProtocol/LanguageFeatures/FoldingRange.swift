import Foundation

/// Client capabilities for the `textDocument/foldingRange` request.
public struct FoldingRangeClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// The maximum number of folding ranges the client supports.
	public var rangeLimit: Int?
	/// Whether the client only supports folding complete lines.
	public var lineFoldingOnly: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool? = nil, rangeLimit: Int? = nil, lineFoldingOnly: Bool? = nil
	) {
		self.dynamicRegistration = dynamicRegistration
		self.rangeLimit = rangeLimit
		self.lineFoldingOnly = lineFoldingOnly
	}
}

/// Parameters for the `textDocument/foldingRange` request.
public struct FoldingRangeParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier) {
		self.textDocument = textDocument
	}
}

/// The kind of a folding range.
public enum FoldingRangeKind: String, CaseIterable, Codable, Hashable, Sendable {
	/// Folding range for a comment.
	case comment
	/// Folding range for imports or includes.
	case imports
	/// Folding range for a region.
	case region
}

/// Represents a folding range.
public struct FoldingRange: Codable, Hashable, Sendable {
	/// The zero-based start line of the range to fold.
	public let startLine: Int
	/// The zero-based character offset from where the folded range starts.
	public let startCharacter: Int?
	/// The zero-based end line of the range to fold.
	public let endLine: Int
	/// The zero-based character offset before the folded range ends.
	public let endCharacter: Int?
	/// Describes the kind of the folding range.
	public let kind: FoldingRangeKind?

	/// Creates an instance from its parts.
	public init(
		startLine: Int, startCharacter: Int? = nil, endLine: Int,
		endCharacter: Int? = nil, kind: FoldingRangeKind? = nil
	) {
		self.startLine = startLine
		self.startCharacter = startCharacter
		self.endLine = endLine
		self.endCharacter = endCharacter
		self.kind = kind
	}
}

/// The response type for `textDocument/foldingRange`.
public typealias FoldingRangeResponse = [FoldingRange]?
