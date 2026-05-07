import Foundation

/// Parameters for the `textDocument/colorPresentation` request.
public struct ColorPresentationParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The color information to request presentations for.
	public let color: Color
	/// The range where the color would be inserted.
	public let range: LSPRange

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier, color: Color, range: LSPRange
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.color = color
		self.range = range
	}
}

/// A color presentation.
public struct ColorPresentation: Codable, Hashable, Sendable {
	/// The label of this color presentation.
	public let label: String
	/// An edit which is applied to a document when selecting this presentation.
	public let textEdit: TextEdit?
	/// Additional text edits applied when selecting this color presentation.
	public let additionalTextEdits: [TextEdit]?

	/// Creates an instance from its parts.
	public init(
		label: String, textEdit: TextEdit? = nil, additionalTextEdits: [TextEdit]? = nil
	) {
		self.label = label
		self.textEdit = textEdit
		self.additionalTextEdits = additionalTextEdits
	}
}

/// The response type for `textDocument/colorPresentation`.
public typealias ColorPresentationResponse = [ColorPresentation]
