import Foundation

/// Client capabilities for the code lens feature.
public typealias CodeLensClientCapabilities = DynamicRegistrationClientCapabilities

/// Workspace client capabilities specific to code lens.
public struct CodeLensWorkspaceClientCapabilities: Codable, Hashable, Sendable {
	/// Whether the client supports a refresh request sent from the server.
	public var refreshSupport: Bool?

	/// Creates an instance from its parts.
	public init(refreshSupport: Bool? = nil) {
		self.refreshSupport = refreshSupport
	}
}

/// Server capabilities for the code lens feature.
public struct CodeLensOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// Whether code lens has a resolve provider.
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, resolveProvider: Bool? = nil) {
		self.workDoneProgress = workDoneProgress
		self.resolveProvider = resolveProvider
	}
}

/// Registration options for code lens.
public struct CodeLensRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration.
	public var documentSelector: DocumentSelector?
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// Whether code lens has a resolve provider.
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil,
		resolveProvider: Bool? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
		self.resolveProvider = resolveProvider
	}
}

/// Parameters for the `textDocument/codeLens` request.
public struct CodeLensParams: Codable, Hashable, Sendable {
	/// The document to request code lens for.
	public var textDocument: TextDocumentIdentifier
	/// An optional work done progress token.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial result progress.
	public var partialResultToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil
	) {
		self.textDocument = textDocument
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
	}
}

/// A code lens represents a command that should be shown along with source text.
public struct CodeLens: Codable, Hashable, Sendable {
	/// The range in which this code lens is valid.
	public var range: LSPRange
	/// The command this code lens represents.
	public var command: Command?
	/// A data entry field that is preserved on a code lens item between request rounds.
	public var data: LSPAny?

	/// Creates an instance from its parts.
	public init(range: LSPRange, command: Command? = nil, data: LSPAny? = nil) {
		self.range = range
		self.command = command
		self.data = data
	}
}

/// The response type for `textDocument/codeLens`.
public typealias CodeLensResponse = [CodeLens]?

/// The response type for `codeLens/resolve`.
public typealias CodeLensResolveResponse = CodeLens
