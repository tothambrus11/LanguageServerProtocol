import Foundation

/// Client capabilities for the `textDocument/documentSymbol` request.
public struct DocumentSymbolClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// The symbol kinds the client supports.
	public var symbolKind: ValueSet<SymbolKind>?
	/// Whether the client supports hierarchical document symbols.
	public var hierarchicalDocumentSymbolSupport: Bool?
	/// The client supports symbol tags.
	///
	/// - Since: 3.16.0
	public var tagSupport: ValueSet<SymbolTag>?
	/// Whether the client supports the `label` property on document symbols.
	public var labelSupport: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool, symbolKind: ValueSet<SymbolKind>? = nil,
		hierarchicalDocumentSymbolSupport: Bool? = nil, tagSupport: ValueSet<SymbolTag>? = nil,
		labelSupport: Bool? = nil
	) {
		self.dynamicRegistration = dynamicRegistration
		self.symbolKind = symbolKind
		self.hierarchicalDocumentSymbolSupport = hierarchicalDocumentSymbolSupport
		self.tagSupport = tagSupport
		self.labelSupport = labelSupport
	}
}

/// Parameters for the `textDocument/documentSymbol` request.
public struct DocumentSymbolParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier) {
		self.textDocument = textDocument
	}
}

/// Represents programming constructs like variables, classes, interfaces etc. in a document.
public struct DocumentSymbol: Codable, Hashable, Sendable {
	/// Creates an instance from its parts.
	public init(
		name: String, detail: String? = nil, kind: SymbolKind, deprecated: Bool? = nil,
		range: LSPRange, selectionRange: LSPRange, children: [DocumentSymbol]? = nil
	) {
		self.name = name
		self.detail = detail
		self.kind = kind
		self.deprecated = deprecated
		self.range = range
		self.selectionRange = selectionRange
		self.children = children
	}

	/// The name of this symbol.
	public let name: String
	/// More detail for this symbol, e.g. the signature of a function.
	public let detail: String?
	/// The kind of this symbol.
	public let kind: SymbolKind
	/// Whether the symbol is deprecated.
	public let deprecated: Bool?
	/// The range enclosing this symbol.
	public let range: LSPRange
	/// The range that should be selected and revealed when this symbol is being picked.
	public let selectionRange: LSPRange
	/// Children of this symbol, e.g. properties of a class.
	public let children: [DocumentSymbol]?
}

/// The response type for `textDocument/documentSymbol`.
public typealias DocumentSymbolResponse = TwoTypeOption<[DocumentSymbol], [SymbolInformation]>?
