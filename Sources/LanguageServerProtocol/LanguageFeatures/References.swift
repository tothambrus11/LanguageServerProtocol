import Foundation

/// Client capabilities for the `textDocument/references` request.
public typealias ReferenceClientCapabilities = DynamicRegistrationClientCapabilities

/// Context for the `textDocument/references` request.
public struct ReferenceContext: Codable, Hashable, Sendable {
	/// Include the declaration of the current symbol.
	public let includeDeclaration: Bool

	/// Creates an instance from its parts.
	public init(includeDeclaration: Bool) {
		self.includeDeclaration = includeDeclaration
	}
}

/// Parameters for the `textDocument/references` request.
public struct ReferenceParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position
	/// The reference context.
	public let context: ReferenceContext

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, position: Position,
		context: ReferenceContext
	) {
		self.textDocument = textDocument
		self.position = position
		self.context = context
	}

	/// Creates an instance with an `includeDeclaration` flag.
	public init(
		textDocument: TextDocumentIdentifier, position: Position, includeDeclaration: Bool = false
	) {
		let ctx = ReferenceContext(includeDeclaration: includeDeclaration)

		self.init(textDocument: textDocument, position: position, context: ctx)
	}
}

/// The response type for `textDocument/references`.
public typealias ReferenceResponse = [Location]?
