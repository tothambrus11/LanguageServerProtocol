import Foundation

/// A configuration item to request from the client.
public struct ConfigurationItem: Codable, Hashable, Sendable {
	/// The scope to get the configuration section for.
	public var scopeUri: DocumentUri?
	/// The configuration section asked for.
	public var section: String?

	/// Creates an instance from its parts.
	public init(scopeUri: DocumentUri?, section: String?) {
		self.scopeUri = scopeUri
		self.section = section
	}
}

/// Parameters for the `workspace/configuration` request.
public struct ConfigurationParams: Codable, Hashable, Sendable {
	/// The configuration items to ask for.
	public var items: [ConfigurationItem]

	/// Creates an instance from its parts.
	public init(items: [ConfigurationItem]) {
		self.items = items
	}
}
