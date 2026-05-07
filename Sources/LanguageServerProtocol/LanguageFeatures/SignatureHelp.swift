import Foundation

/// Client capabilities for the `textDocument/signatureHelp` request.
public struct SignatureHelpClientCapabilities: Codable, Hashable, Sendable {
	/// Client capabilities specific to signature information.
	public struct SignatureInformation: Codable, Hashable, Sendable {
		/// Client capabilities specific to parameter information.
		public struct ParameterInformation: Codable, Hashable, Sendable {
			/// Whether the client supports processing label offsets.
			///
			/// - Since: 3.14.0
			public var labelOffsetSupport: Bool?

			/// Creates an instance from its parts.
			public init(labelOffsetSupport: Bool? = nil) {
				self.labelOffsetSupport = labelOffsetSupport
			}
		}

		/// The content formats for documentation the client supports.
		public var documentationFormat: [MarkupKind]?
		/// Client capabilities specific to parameter information.
		public var parameterInformation: ParameterInformation?
		/// Whether the client supports the `activeParameter` property.
		///
		/// - Since: 3.16.0
		public var activeParameterSupport: Bool?

		/// Creates an instance from its parts.
		public init(
			documentationFormat: [MarkupKind]? = nil,
			parameterInformation: ParameterInformation? = nil, activeParameterSupport: Bool? = nil
		) {
			self.documentationFormat = documentationFormat
			self.parameterInformation = parameterInformation
			self.activeParameterSupport = activeParameterSupport
		}

		/// Creates an instance using a label offset support flag.
		public init(
			documentationFormat: [MarkupKind]? = nil, labelOffsetSupport: Bool? = nil,
			activeParameterSupport: Bool? = nil
		) {
			self.init(
				documentationFormat: documentationFormat,
				parameterInformation: ParameterInformation(labelOffsetSupport: labelOffsetSupport),
				activeParameterSupport: activeParameterSupport)
		}
	}

	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Client capabilities specific to signature information.
	public var signatureInformation: SignatureInformation?
	/// Whether the client supports sending additional context information.
	///
	/// - Since: 3.15.0
	public var contextSupport: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool?,
		signatureInformation: SignatureHelpClientCapabilities.SignatureInformation?,
		contextSupport: Bool?
	) {
		self.dynamicRegistration = dynamicRegistration
		self.signatureInformation = signatureInformation
		self.contextSupport = contextSupport
	}
}

/// Represents a parameter of a callable-signature.
public struct ParameterInformation: Codable, Hashable, Sendable {
	/// The label of this parameter information.
	public var label: TwoTypeOption<String, [UInt]>
	/// The human-readable doc-comment of this parameter.
	public var documentation: TwoTypeOption<String, MarkupContent>?

	/// Creates an instance from its parts.
	public init(
		label: TwoTypeOption<String, [UInt]>,
		documentation: TwoTypeOption<String, MarkupContent>? = nil
	) {
		self.label = label
		self.documentation = documentation
	}
}

/// Represents the signature of something callable.
public struct SignatureInformation: Codable, Hashable, Sendable {
	/// The label of this signature.
	public var label: String
	/// The human-readable doc-comment of this signature.
	public var documentation: TwoTypeOption<String, MarkupContent>?
	/// The parameters of this signature.
	public var parameters: [ParameterInformation]?
	/// The index of the active parameter.
	///
	/// - Since: 3.16.0
	public var activeParameter: UInt?

	/// Creates an instance from its parts.
	public init(
		label: String, documentation: TwoTypeOption<String, MarkupContent>? = nil,
		parameters: [ParameterInformation]? = nil, activeParameter: UInt? = nil
	) {
		self.label = label
		self.documentation = documentation
		self.parameters = parameters
		self.activeParameter = activeParameter
	}
}

/// Signature help represents the signature of something callable.
public struct SignatureHelp: Codable, Hashable, Sendable {
	/// One or more signatures.
	public let signatures: [SignatureInformation]
	/// The active signature.
	public let activeSignature: Int?
	/// The active parameter of the active signature.
	public let activeParameter: Int?

	/// Creates an instance from its parts.
	public init(
		signatures: [SignatureInformation], activeSignature: Int? = nil, activeParameter: Int? = nil
	) {
		self.signatures = signatures
		self.activeSignature = activeSignature
		self.activeParameter = activeParameter
	}
}

/// Registration options for signature help.
public struct SignatureHelpRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration, if any.
	public let documentSelector: DocumentSelector?
	/// The characters that trigger signature help, if any.
	public let triggerCharacters: [String]?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil,
		triggerCharacters: [String]? = nil
	) {
		self.documentSelector = documentSelector
		self.triggerCharacters = triggerCharacters
	}
}

/// The response type for `textDocument/signatureHelp`.
public typealias SignatureHelpResponse = SignatureHelp?
