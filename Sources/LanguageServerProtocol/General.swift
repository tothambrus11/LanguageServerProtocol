import Foundation

/// The initial trace setting sent during initialization.
public enum Tracing: String, Codable, Hashable, Sendable {
	/// Tracing is disabled.
	case off
	/// Only messages are traced.
	case messages
	/// Messages and verbose output are traced.
	case verbose
}

/// Parameters for the `initialize` request.
public struct InitializeParams: Codable, Hashable, Sendable {
	/// Information about the client.
	public struct ClientInfo: Codable, Hashable, Sendable {
		/// The name of the client as defined by the client.
		public let name: String
		/// The client's version as defined by the client, if any.
		public let version: String?

		/// Creates an instance from its parts.
		public init(name: String, version: String? = nil) {
			self.name = name
			self.version = version
		}
	}

	/// The process id of the parent process that started the server, if known.
	public let processId: Int?
	/// Information about the client, if any.
	public let clientInfo: ClientInfo?
	/// The locale the client is currently showing the user interface in, if any.
	public let locale: String?
	/// The rootPath of the workspace, if any.
	public let rootPath: String?
	/// The rootUri of the workspace, if any.
	public let rootUri: DocumentUri?
	/// User-provided initialization options, if any.
	public let initializationOptions: LSPAny?
	/// The capabilities provided by the client (editor or tool).
	public let capabilities: ClientCapabilities
	/// The initial trace setting, if any.
	public let trace: Tracing?
	/// The workspace folders configured in the client when the server starts, if any.
	public let workspaceFolders: [WorkspaceFolder]?

	/// Creates an instance from its parts.
	public init(
		processId: Int?,
		clientInfo: ClientInfo? = nil,
		locale: String?,
		rootPath: String?,
		rootUri: DocumentUri?,
		initializationOptions: LSPAny?,
		capabilities: ClientCapabilities,
		trace: Tracing?,
		workspaceFolders: [WorkspaceFolder]?
	) {
		self.processId = processId
		self.clientInfo = clientInfo
		self.locale = locale
		self.rootPath = rootPath
		self.rootUri = rootUri
		self.initializationOptions = initializationOptions
		self.capabilities = capabilities
		self.trace = trace
		self.workspaceFolders = workspaceFolders
	}
}

/// Information about the server.
public struct ServerInfo: Codable, Hashable, Sendable {
	/// The name of the server as defined by the server.
	public var name: String
	/// The server's version as defined by the server, if any.
	public var version: String?

	/// Creates an instance from its parts.
	public init(name: String, version: String?) {
		self.name = name
		self.version = version
	}
}

/// The result returned from the `initialize` request.
public struct InitializationResponse: Codable, Hashable, Sendable {
	/// The capabilities the server provides.
	public let capabilities: ServerCapabilities
	/// Information about the server, if any.
	public let serverInfo: ServerInfo?

	/// Creates an instance from its parts.
	public init(capabilities: ServerCapabilities, serverInfo: ServerInfo?) {
		self.capabilities = capabilities
		self.serverInfo = serverInfo
	}
}

/// Parameters for the `initialized` notification (empty).
public struct InitializedParams: Codable, Hashable, Sendable {
	/// Creates an instance.
	public init() {
	}
}
