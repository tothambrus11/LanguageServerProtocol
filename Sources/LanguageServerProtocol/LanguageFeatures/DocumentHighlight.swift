import Foundation

/// Client capabilities for the document highlight feature.
public typealias DocumentHighlightClientCapabilities = DynamicRegistrationClientCapabilities

/// Server capabilities for the document highlight feature.
public typealias DocumentHighlightOptions = WorkDoneProgressOptions

/// Registration options for document highlight.
public struct DocumentHighlightRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
	}
}

/// Parameters for the `textDocument/documentHighlight` request.
public struct DocumentHighlightParams: Codable, Hashable, Sendable {
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public var position: Position
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public var partialResultToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, position: Position,
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil
	) {
		self.textDocument = textDocument
		self.position = position
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
	}
}

/// A document highlight kind.
public enum DocumentHighlightKind: Int, CaseIterable, Codable, Hashable, Sendable {
	/// A textual occurrence.
	case Text = 1
	/// Read-access of a symbol.
	case Read = 2
	/// Write-access of a symbol.
	case Write = 3
}

/// A document highlight is a range inside a text document that deserves special attention.
public struct DocumentHighlight: Codable, Hashable, Sendable {
	/// The range this highlight applies to.
	public var range: LSPRange
	/// The highlight kind, defaults to text.
	public var kind: DocumentHighlightKind?

	/// Creates an instance from its parts.
	public init(
		range: LSPRange, kind: DocumentHighlightKind? = nil
	) {
		self.range = range
		self.kind = kind
	}
}

/// The response type for `textDocument/documentHighlight`.
public typealias DocumentHighlightResponse = [DocumentHighlight]?
