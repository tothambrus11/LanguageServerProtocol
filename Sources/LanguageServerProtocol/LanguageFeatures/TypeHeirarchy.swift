import Foundation

/// Server capabilities for the type hierarchy feature.
///
/// - Since: 3.17.0
public typealias TypeHierarchyOptions = WorkDoneProgressOptions

/// Registration options for type hierarchy.
///
/// - Since: 3.17.0
public struct TypeHierarchyRegistrationOptions: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier,
		position: Position,
		workDoneToken: ProgressToken? = nil
	) {
		self.textDocument = textDocument
		self.position = position
		self.workDoneToken = workDoneToken
	}
}

/// Parameters for the `textDocument/prepareTypeHierarchy` request.
///
/// - Since: 3.17.0
public struct TypeHierarchyPrepareParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier,
		position: Position,
		workDoneToken: ProgressToken? = nil
	) {
		self.textDocument = textDocument
		self.position = position
		self.workDoneToken = workDoneToken
	}
}

/// Represents programming constructs in the context of type hierarchy.
///
/// - Since: 3.17.0
public struct TypeHierarchyItem: Codable, Hashable, Sendable {
	/// The name of this item.
	public let name: String
	/// The kind of this item.
	public let kind: SymbolKind
	/// Tags for this item.
	public let tags: [SymbolTag]?
	/// More detail for this item, e.g. the signature of a function.
	public let detail: String?
	/// The resource identifier of this item.
	public let uri: DocumentUri
	/// The range enclosing this symbol.
	public let range: LSPRange
	/// The range that should be selected and revealed.
	public let selectionRange: LSPRange
	/// A data entry field preserved between request rounds.
	public let data: LSPAny?

	/// Creates an instance from its parts.
	public init(
		name: String,
		kind: SymbolKind,
		tags: [SymbolTag]? = nil,
		detail: String? = nil,
		uri: DocumentUri,
		range: LSPRange,
		selectionRange: LSPRange,
		data: LSPAny? = nil
	) {
		self.name = name
		self.kind = kind
		self.tags = tags
		self.detail = detail
		self.uri = uri
		self.range = range
		self.selectionRange = selectionRange
		self.data = data
	}
}

/// The response type for `textDocument/prepareTypeHierarchy`.
public typealias PrepareTypeHeirarchyResponse = [TypeHierarchyItem]?

/// Parameters for the `typeHierarchy/subtypes` request.
///
/// - Since: 3.17.0
public struct TypeHierarchySubtypesParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The type hierarchy item to resolve subtypes for.
	public let item: TypeHierarchyItem

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		item: TypeHierarchyItem
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.item = item
	}
}

/// The response type for `typeHierarchy/subtypes`.
public typealias TypeHierarchySubtypesResponse = [TypeHierarchyItem]?

/// Parameters for the `typeHierarchy/supertypes` request.
///
/// - Since: 3.17.0
public struct TypeHierarchySupertypesParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The type hierarchy item to resolve supertypes for.
	public let item: TypeHierarchyItem

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		item: TypeHierarchyItem
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.item = item
	}
}

/// The response type for `typeHierarchy/supertypes`.
public typealias TypeHierarchySupertypesResponse = [TypeHierarchyItem]?
