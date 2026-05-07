import Foundation

extension Registration {
	/// The client request method this registration corresponds to, if any.
	public var requestMethod: ClientRequest.Method? {
		return ClientRequest.Method(rawValue: method)
	}

	/// The client notification method this registration corresponds to, if any.
	public var notificationMethod: ClientNotification.Method? {
		return ClientNotification.Method(rawValue: method)
	}
}

extension Unregistration {
	/// The client request method this unregistration corresponds to, if any.
	public var requestMethod: ClientRequest.Method? {
		return ClientRequest.Method(rawValue: method)
	}

	/// The client notification method this unregistration corresponds to, if any.
	public var notificationMethod: ClientNotification.Method? {
		return ClientNotification.Method(rawValue: method)
	}
}

extension ServerCapabilities {
	/// Applies multiple dynamic registrations to the server capabilities.
	public mutating func applyRegistrations(_ registrations: [Registration]) throws {
		try registrations.forEach({ try applyRegistration($0) })
	}

	/// Applies a single dynamic registration to the server capabilities.
	public mutating func applyRegistration(_ registration: Registration) throws {
		switch registration.requestMethod {
		case .textDocumentSemanticTokens:
			let data = try JSONEncoder().encode(registration.registerOptions)
			let options = try JSONDecoder().decode(
				TwoTypeOption<SemanticTokensOptions, SemanticTokensRegistrationOptions>.self,
				from: data)

			self.semanticTokensProvider = options
			return
		case .textDocumentCompletion:
			let data = try JSONEncoder().encode(registration.registerOptions)
			let options = try JSONDecoder().decode(CompletionOptions.self, from: data)

			self.completionProvider = options
			return
		default:
			break
		}

		switch registration.notificationMethod {
		case .workspaceDidChangeWatchedFiles:
			break
		default:
			break
		}
	}

	/// Applies multiple dynamic unregistrations to the server capabilities.
	public mutating func applyUnregistrations(_ unregistrations: [Unregistration]) throws {
		try unregistrations.forEach({ try applyUnregistration($0) })
	}

	/// Applies a single dynamic unregistration to the server capabilities.
	public mutating func applyUnregistration(_ unregistration: Unregistration) throws {
		switch unregistration.requestMethod {
		case .textDocumentSemanticTokens:
			self.semanticTokensProvider = nil
			return
		case .textDocumentCompletion:
			self.completionProvider = nil
			return
		default:
			break
		}

		switch unregistration.notificationMethod {
		case .workspaceDidChangeWatchedFiles:
			break
		default:
			break
		}
	}
}

extension TwoTypeOption where T == TextDocumentSyncOptions, U == TextDocumentSyncKind {
	/// Returns effective text document sync options regardless of the option form.
	public var effectiveOptions: TextDocumentSyncOptions {
		switch self {
		case .optionA(let value):
			return value
		case .optionB(let changeKind):
			return TextDocumentSyncOptions(
				openClose: false, change: changeKind, willSave: false, willSaveWaitUntil: false,
				save: nil)
		}
	}
}

extension TwoTypeOption where T == SemanticTokensOptions, U == SemanticTokensRegistrationOptions {
	/// Returns effective semantic tokens options regardless of the option form.
	public var effectiveOptions: SemanticTokensOptions {
		switch self {
		case .optionA(let options):
			return options
		case .optionB(let registrationOptions):
			return SemanticTokensOptions(
				workDoneProgress: registrationOptions.workDoneProgress,
				legend: registrationOptions.legend,
				range: registrationOptions.range,
				full: registrationOptions.full)
		}
	}
}

extension SemanticTokensClientCapabilities.Requests.RangeOption {
	/// Whether range requests are supported.
	public var supported: Bool {
		switch self {
		case .optionA(let value):
			return value
		case .optionB(_):
			return true
		}
	}
}

extension SemanticTokensClientCapabilities.Requests.FullOption {
	/// Whether full requests are supported.
	public var supported: Bool {
		switch self {
		case .optionA(let value):
			return value
		case .optionB(_):
			return true
		}
	}

	/// Whether delta updates are supported for full requests.
	public var deltaSupported: Bool {
		switch self {
		case .optionA(_):
			return false
		case .optionB(let full):
			return full.delta ?? false
		}
	}
}
