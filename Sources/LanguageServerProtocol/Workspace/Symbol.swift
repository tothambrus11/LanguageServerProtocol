import Foundation

/// Client capabilities for the `workspace/symbol` request.
public struct WorkspaceSymbolClientCapabilities: Codable, Hashable, Sendable {
	/// The properties that a client can resolve lazily.
	public struct Properties: Codable, Hashable, Sendable {
		/// The properties that a client can resolve lazily.
		public var properties: [String]
	}

	/// Whether the client supports dynamic registration.
	public var dynamicRegistration: Bool?
	/// The symbol kind values the client supports.
	public var symbolKind: ValueSet<SymbolKind>?
	/// The tag values the client supports.
	///
	/// - Since: 3.16.0
	public var tagSupport: ValueSet<SymbolTag>?
	/// The client supports partial result for resolve.
	///
	/// - Since: 3.17.0
	public var resolveSupport: Properties?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool?, symbolKind: [SymbolKind]?, tagSupport: [SymbolTag]?,
		resolveSupport: Properties?
	) {
		self.dynamicRegistration = dynamicRegistration
		self.symbolKind = symbolKind.map { ValueSet(valueSet: $0) }
		self.tagSupport = tagSupport.map { ValueSet(valueSet: $0) }
		self.resolveSupport = resolveSupport
	}

	/// Creates an instance from property names.
	public init(
		dynamicRegistration: Bool?, symbolKind: [SymbolKind]?, tagSupport: [SymbolTag]?,
		resolveSupport: [String]?
	) {
		self.init(
			dynamicRegistration: dynamicRegistration,
			symbolKind: symbolKind,
			tagSupport: tagSupport,
			resolveSupport: resolveSupport.map { Properties(properties: $0) })
	}
}

/// Server capabilities for `workspace/symbol`.
public struct WorkspaceSymbolOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// Whether the server supports resolving additional information for a workspace symbol.
	///
	/// - Since: 3.17.0
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, resolveProvider: Bool? = nil) {
		self.workDoneProgress = workDoneProgress
		self.resolveProvider = resolveProvider
	}
}

/// Registration options for `workspace/symbol`.
public typealias WorkspaceSymbolRegistrationOptions = WorkspaceSymbolOptions

/// Parameters for the `workspace/symbol` request.
public struct WorkspaceSymbolParams: Codable, Hashable, Sendable {
	/// An optional work done progress token.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial result progress.
	public var partialResultToken: ProgressToken?
	/// A query string to filter symbols by.
	public var query: String

	/// Creates an instance from its parts.
	public init(
		query: String, workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.query = query
	}
}

/// A special workspace symbol that supports partial document references.
///
/// - Since: 3.17.0
public struct WorkspaceSymbol: Codable, Hashable, Sendable {
	/// The name of this symbol.
	public var name: String
	/// The kind of this symbol.
	public var kind: SymbolKind
	/// Tags for this symbol.
	public var tags: [SymbolTag]?
	/// The location of this symbol (full location or just the containing document).
	public var location: TwoTypeOption<Location, TextDocumentIdentifier>?
	/// The name of the symbol containing this symbol, if any.
	public var containerName: String?

	/// Creates an instance from its parts.
	public init(
		name: String, kind: SymbolKind, tags: [SymbolTag]? = nil,
		location: TwoTypeOption<Location, TextDocumentIdentifier>? = nil,
		containerName: String? = nil
	) {
		self.name = name
		self.kind = kind
		self.tags = tags
		self.location = location
		self.containerName = containerName
	}
}

/// The response type for `workspace/symbol`.
public typealias WorkspaceSymbolResponse = TwoTypeOption<[SymbolInformation], [WorkspaceSymbol]>?
