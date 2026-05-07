import Foundation

/// Server capabilities for the diagnostic pull model.
///
/// - Since: 3.17.0
public struct DiagnosticOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public let workDoneProgress: Bool?
	/// An optional identifier under which the diagnostics are managed.
	public let identifier: String?
	/// Whether the language has inter-file dependencies.
	public let interFileDependencies: Bool
	/// Whether the server provides workspace diagnostics.
	public let workspaceDiagnostics: Bool

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil, identifier: String? = nil, interFileDependencies: Bool,
		workspaceDiagnostics: Bool
	) {
		self.workDoneProgress = workDoneProgress
		self.identifier = identifier
		self.interFileDependencies = interFileDependencies
		self.workspaceDiagnostics = workspaceDiagnostics
	}
}

/// Registration options for the diagnostic pull model.
///
/// - Since: 3.17.0
public struct DiagnosticRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration, if any.
	public let documentSelector: DocumentSelector?
	/// Whether the server supports work done progress.
	public let workDoneProgress: Bool?
	/// An optional identifier under which the diagnostics are managed.
	public let identifier: String?
	/// Whether the language has inter-file dependencies.
	public let interFileDependencies: Bool
	/// Whether the server provides workspace diagnostics.
	public let workspaceDiagnostics: Bool
	/// The id used to register the request, if any.
	public let id: String?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil,
		identifier: String? = nil, interFileDependencies: Bool, workspaceDiagnostics: Bool,
		id: String? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
		self.identifier = identifier
		self.interFileDependencies = interFileDependencies
		self.workspaceDiagnostics = workspaceDiagnostics
		self.id = id
	}
}

/// Client capabilities for `textDocument/publishDiagnostics`.
public struct PublishDiagnosticsClientCapabilities: Codable, Hashable, Sendable {
	/// Whether the client supports related information in diagnostics.
	public var relatedInformation: Bool?
	/// The client supports diagnostic tags.
	public var tagSupport: ValueSet<DiagnosticTag>?
	/// Whether the client interprets the version property of diagnostics.
	public var versionSupport: Bool?
	/// Whether the client supports `codeDescription` on diagnostics.
	public var codeDescriptionSupport: Bool?
	/// Whether the client supports the `data` property on diagnostics.
	public var dataSupport: Bool?

	/// Creates an instance from its parts.
	public init(
		relatedInformation: Bool? = nil, tagSupport: ValueSet<DiagnosticTag>? = nil,
		versionSupport: Bool? = nil, codeDescriptionSupport: Bool? = nil, dataSupport: Bool? = nil
	) {
		self.relatedInformation = relatedInformation
		self.tagSupport = tagSupport
		self.versionSupport = versionSupport
		self.codeDescriptionSupport = codeDescriptionSupport
		self.dataSupport = dataSupport
	}
}

/// Client capabilities for the diagnostic pull model.
///
/// - Since: 3.17.0
public struct DiagnosticClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Whether the client supports related document diagnostics.
	public var relatedDocumentSupport: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool? = nil, relatedDocumentSupport: Bool?) {
		self.dynamicRegistration = dynamicRegistration
		self.relatedDocumentSupport = relatedDocumentSupport
	}
}

/// Represents a related message and source code location for a diagnostic.
public struct DiagnosticRelatedInformation: Codable, Hashable, Sendable {
	/// The location of this related diagnostic information.
	public let location: Location
	/// The message of this related diagnostic information.
	public let message: String

	/// Creates an instance from its parts.
	public init(location: Location, message: String) {
		self.location = location
		self.message = message
	}
}

/// The diagnostic's code, which might appear in the user interface.
public typealias DiagnosticCode = TwoTypeOption<Int, String>

/// The diagnostic's severity.
public enum DiagnosticSeverity: Int, CaseIterable, Codable, Hashable, Sendable {
	/// Reports an error.
	case error = 1
	/// Reports a warning.
	case warning = 2
	/// Reports an information.
	case information = 3
	/// Reports a hint.
	case hint = 4
}

/// The diagnostic tags.
///
/// - Since: 3.15.0
public enum DiagnosticTag: Int, CaseIterable, Codable, Hashable, Sendable {
	/// Unused or unnecessary code.
	case unnecessary = 1
	/// Deprecated or obsolete code.
	case deprecated = 2
}

/// Structure to capture a description for an error code.
///
/// - Since: 3.16.0
public struct CodeDescription: Codable, Hashable, Sendable {
	/// An URI to open with more information about the diagnostic error.
	public let href: URI

	/// Creates an instance from its parts.
	public init(href: URI) {
		self.href = href
	}
}

/// Represents a diagnostic, such as a compiler error or warning.
public struct Diagnostic: Codable, Hashable, Sendable {
	/// The range at which the message applies.
	public let range: LSPRange
	/// The diagnostic's severity.
	public let severity: DiagnosticSeverity?
	/// The diagnostic's code.
	public let code: DiagnosticCode?
	/// An optional property to describe the error code.
	///
	/// - Since: 3.16.0
	public let codeDescription: CodeDescription?
	/// A human-readable string describing the source of this diagnostic.
	public let source: String?
	/// The diagnostic's message.
	public let message: String
	/// Additional metadata about the diagnostic.
	///
	/// - Since: 3.15.0
	public let tags: [DiagnosticTag]?
	/// An array of related diagnostic information.
	public let relatedInformation: [DiagnosticRelatedInformation]?

	/// Creates an instance from its parts.
	public init(
		range: LSPRange, severity: DiagnosticSeverity? = nil, code: DiagnosticCode? = nil,
		codeDescription: CodeDescription? = nil, source: String? = nil, message: String,
		tags: [DiagnosticTag]? = nil, relatedInformation: [DiagnosticRelatedInformation]? = nil
	) {
		self.range = range
		self.severity = severity
		self.code = code
		self.codeDescription = codeDescription
		self.source = source
		self.message = message
		self.tags = tags
		self.relatedInformation = relatedInformation
	}
}

/// Parameters for the `textDocument/publishDiagnostics` notification.
public struct PublishDiagnosticsParams: Codable, Hashable, Sendable {
	/// The URI for which diagnostic information is reported.
	public let uri: DocumentUri
	/// The version number of the document the diagnostics are published for.
	public let version: Int?
	/// An array of diagnostic information items.
	public let diagnostics: [Diagnostic]

	/// Creates an instance from its parts.
	public init(uri: DocumentUri, version: Int? = nil, diagnostics: [Diagnostic]) {
		self.uri = uri
		self.version = version
		self.diagnostics = diagnostics
	}
}

/// Parameters for the `textDocument/diagnostic` request.
///
/// - Since: 3.17.0
public struct DocumentDiagnosticParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The additional identifier provided during registration, if any.
	public let identifier: String?
	/// The result id of a previous response, if known.
	public let previousResultId: String?

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier,
		identifier: String? = nil,
		previousResultId: String? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.identifier = identifier
		self.previousResultId = previousResultId
	}
}

/// The document diagnostic report kind.
///
/// - Since: 3.17.0
public enum DocumentDiagnosticReportKind: String, Codable, Hashable, Sendable, CaseIterable {
	/// A full document diagnostic report.
	case full
	/// An unchanged document diagnostic report.
	case unchanged
}

/// A base document diagnostic report.
public struct BaseDocumentDiagnosticReport: Codable, Hashable, Sendable {
	/// The kind of this diagnostic report.
	public let kind: DocumentDiagnosticReportKind
	/// An optional result id, if any.
	public let resultId: String?
	/// The actual diagnostic items, if any.
	public let items: [Diagnostic]?

	/// Creates an instance from its parts.
	public init(
		kind: DocumentDiagnosticReportKind, resultId: String? = nil, items: [Diagnostic]? = nil
	) {
		self.kind = kind
		self.resultId = resultId
		self.items = items
	}
}

/// A diagnostic report with additional related document information.
public struct RelatedDocumentDiagnosticReport: Codable, Hashable, Sendable {
	/// The kind of this diagnostic report.
	public let kind: DocumentDiagnosticReportKind
	/// An optional result id, if any.
	public let resultId: String?
	/// The actual diagnostic items, if any.
	public let items: [Diagnostic]?
	/// Diagnostics of related documents, if any.
	public let relatedDocuments: [DocumentUri: DocumentDiagnosticReport]?

	/// Creates an instance from its parts.
	public init(
		kind: DocumentDiagnosticReportKind, resultId: String? = nil, items: [Diagnostic]? = nil,
		relatedDocuments: [DocumentUri: DocumentDiagnosticReport]? = nil
	) {
		self.kind = kind
		self.resultId = resultId
		self.items = items
		self.relatedDocuments = relatedDocuments
	}
}

typealias FullDocumentDiagnosticReport = BaseDocumentDiagnosticReport
typealias UnchangedDocumentDiagnosticReport = BaseDocumentDiagnosticReport
typealias RelatedFullDocumentDiagnosticReport = RelatedDocumentDiagnosticReport
typealias RelatedUnchangedDocumentDiagnosticReport = RelatedDocumentDiagnosticReport

/// The response type for `textDocument/diagnostic`.
public typealias DocumentDiagnosticReport = RelatedDocumentDiagnosticReport
