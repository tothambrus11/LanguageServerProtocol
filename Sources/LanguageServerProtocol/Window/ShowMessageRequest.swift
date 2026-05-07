import Foundation

/// An action item presented in a `window/showMessageRequest`.
public struct MessageActionItem: Codable, Hashable, Sendable {
	/// A short title shown in the UI for this action.
	public var title: String

	/// Creates an instance from its parts.
	public init(title: String) {
		self.title = title
	}
}

/// Parameters for the `window/showMessageRequest` request.
public struct ShowMessageRequestParams: Codable, Hashable, Sendable {
	/// The message type.
	public var type: MessageType
	/// The actual message.
	public var message: String
	/// The message action items to present, if any.
	public var actions: [MessageActionItem]?

	/// Creates an instance from its parts.
	public init(type: MessageType, message: String, actions: [MessageActionItem]? = nil) {
		self.type = type
		self.message = message
		self.actions = actions
	}
}

extension ShowMessageRequestParams: CustomStringConvertible {
	public var description: String {
		return "\(type): \(message)"
	}
}

/// The response type for `window/showMessageRequest`.
public typealias ShowMessageRequestResponse = MessageActionItem?
