import Foundation

/// The message type used in `window/showMessage` and `window/logMessage`.
public enum MessageType: Int, Codable, Hashable, Sendable {
	/// An error message.
	case error = 1
	/// A warning message.
	case warning = 2
	/// An information message.
	case info = 3
	/// A log message.
	case log = 4
}

extension MessageType: CustomStringConvertible {
	public var description: String {
		switch self {
		case .error:
			return "error"
		case .warning:
			return "warning"
		case .info:
			return "info"
		case .log:
			return "log"
		}
	}
}

/// Parameters for the `window/logMessage` notification.
public struct LogMessageParams: Codable, Hashable, Sendable {
	/// The message type.
	public let type: MessageType
	/// The actual message.
	public let message: String

	/// Creates an instance from its parts.
	public init(type: MessageType, message: String) {
		self.type = type
		self.message = message
	}
}

extension LogMessageParams: CustomStringConvertible {
	public var description: String {
		return "\(type): \(message)"
	}
}

/// Parameters for the `window/showMessage` notification.
public typealias ShowMessageParams = LogMessageParams

/// Parameters for the `window/showDocument` request.
public struct ShowDocumentParams: Hashable, Codable, Sendable {
	/// The URI to show.
	public var uri: URI
	/// Whether to show the resource in an external program.
	public var external: Bool?
	/// Whether the editor should take focus.
	public var takeFocus: Bool?
	/// An optional selection range within the document.
	public var selection: LSPRange?

	/// Creates an instance from its parts.
	public init(uri: URI, external: Bool? = nil, takeFocus: Bool? = nil, selection: LSPRange? = nil)
	{
		self.uri = uri
		self.external = external
		self.takeFocus = takeFocus
		self.selection = selection
	}
}

/// Parameters for the `window/workDoneProgress/create` request.
public struct WorkDoneProgressCreateParams: Hashable, Codable, Sendable {
	/// The token to be used to report progress.
	public var token: ProgressToken

	/// Creates an instance from its parts.
	public init(token: ProgressToken) {
		self.token = token
	}
}

/// Parameters for the `window/workDoneProgress/cancel` notification.
public typealias WorkDoneProgressCancelParams = WorkDoneProgressCreateParams

/// The result of a `window/showDocument` request.
public struct ShowDocumentResult: Hashable, Codable, Sendable {
	/// Whether the show was successful.
	public let success: Bool

	/// Creates an instance from its parts.
	public init(success: Bool) {
		self.success = success
	}
}
