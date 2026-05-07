import Foundation

/// Client capabilities for `workspace/executeCommand`.
public typealias ExecuteCommandClientCapabilities = DynamicRegistrationClientCapabilities

/// Server capabilities for the `workspace/executeCommand` request.
public struct ExecuteCommandOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The commands to be executed on the server.
	public var commands: [String]

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, commands: [String]) {
		self.workDoneProgress = workDoneProgress
		self.commands = commands
	}
}

/// Registration options for execute command.
public typealias ExecuteCommandRegistrationOptions = ExecuteCommandOptions

/// Parameters for the `workspace/executeCommand` request.
public struct ExecuteCommandParams: Codable, Hashable, Sendable {
	/// An optional work done progress token.
	public var workDoneToken: ProgressToken?
	/// The identifier of the actual command handler.
	public var command: String
	/// Arguments the command should be invoked with.
	public var arguments: [LSPAny]?

	/// Creates an instance from its parts.
	public init(workDoneToken: ProgressToken? = nil, command: String, arguments: [LSPAny]? = nil) {
		self.workDoneToken = workDoneToken
		self.command = command
		self.arguments = arguments
	}
}

/// The response type for `workspace/executeCommand`.
public typealias ExecuteCommandResponse = LSPAny
