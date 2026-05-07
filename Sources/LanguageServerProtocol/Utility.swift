import Foundation

/// A generic capability that only indicates whether dynamic registration is supported.
public struct GenericDynamicRegistration: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public let dynamicRegistration: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool) {
		self.dynamicRegistration = dynamicRegistration
	}
}
