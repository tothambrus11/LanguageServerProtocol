import Foundation

/// A general parameter to register a capability.
public struct Registration: Codable, Hashable, Sendable {
	/// The id used to register the request. Can be used to deregister later.
	public var id: String
	/// The method/capability to register for.
	public var method: String
	/// Options necessary for the registration, if any.
	public var registerOptions: LSPAny?

	/// Creates an instance from its parts.
	public init(id: String, method: String, registerOptions: LSPAny? = nil) {
		self.id = id
		self.method = method
		self.registerOptions = registerOptions
	}
}

extension Registration {
	var registerOptionsData: Data? {
		return try? JSONEncoder().encode(registerOptions)
	}

	func reintrepretOptions<T: Decodable>(_ type: T.Type) throws -> T {
		let data = try JSONEncoder().encode(registerOptions)

		return try JSONDecoder().decode(type.self, from: data)
	}

	func decodeServerRegistration() throws -> ServerRegistration {
		guard let regMethod = ServerRegistration.Method(rawValue: method) else {
			throw ProtocolError.unhandledRegistrationMethod(method)
		}

		switch regMethod {
		case .workspaceDidChangeWatchedFiles:
			let options = try reintrepretOptions(DidChangeWatchedFilesRegistrationOptions.self)

			return .workspaceDidChangeWatchedFiles(options)
		case .workspaceDidChangeConfiguration:
			return .workspaceDidChangeConfiguration
		case .workspaceDidChangeWorkspaceFolders:
			return .workspaceDidChangeWorkspaceFolders
		case .textDocumentSemanticTokens:
			let options = try reintrepretOptions(SemanticTokensRegistrationOptions.self)

			return .textDocumentSemanticTokens(options)

		}
	}

	/// The decoded server registration, if the method is recognized.
	public var serverRegistration: ServerRegistration? {
		return try? decodeServerRegistration()
	}
}

/// Parameters for the `client/registerCapability` request.
public struct RegistrationParams: Codable, Hashable, Sendable {
	/// The registrations to apply.
	public var registrations: [Registration]

	/// Creates an instance from its parts.
	public init(registrations: [Registration]) {
		self.registrations = registrations
	}

	/// The decoded server registrations for all recognized methods.
	public var serverRegistrations: [ServerRegistration] {
		return registrations.compactMap({ $0.serverRegistration })
	}
}

/// A general parameter to unregister a capability.
public struct Unregistration: Codable, Hashable, Sendable {
	/// The id used to unregister the request or notification.
	public var id: String
	/// The method/capability to unregister for.
	public var method: String
}

/// Parameters for the `client/unregisterCapability` request.
public struct UnregistrationParams: Codable, Hashable, Sendable {
	/// The unregistrations to apply.
	public var unregistrations: [Unregistration]
}
