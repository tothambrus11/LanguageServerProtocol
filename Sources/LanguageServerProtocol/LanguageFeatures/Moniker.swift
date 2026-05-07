import Foundation

/// Client capabilities for the moniker feature.
///
/// - Since: 3.16.0
public typealias MonikerClientCapabilities = DynamicRegistrationClientCapabilities

/// Parameters for the `textDocument/moniker` request.
///
/// - Since: 3.16.0
public struct MonikerParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?

	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier, position: Position
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.position = position
	}
}

/// The moniker uniqueness level.
///
/// - Since: 3.16.0
public enum UniquenessLevel: Codable, Sendable {
	/// The moniker is only unique inside a document.
	case document
	/// The moniker is unique inside a project.
	case project
	/// The moniker is unique inside the group to which a project belongs.
	case group
	/// The moniker is unique inside the moniker scheme.
	case scheme
	/// The moniker is globally unique.
	case global
}

/// The moniker kind.
///
/// - Since: 3.16.0
public enum MonikerKind: Codable, Sendable {
	/// The moniker represents a symbol imported into a project.
	case _import
	/// The moniker represents a symbol exported from a project.
	case export
	/// The moniker represents a symbol local to a project.
	case local
}

/// Moniker definition to match LSIF 0.5 moniker definition.
///
/// - Since: 3.16.0
public struct Moniker: Codable, Sendable {
	/// The scheme of the moniker.
	public let scheme: String
	/// The identifier of the moniker.
	public let identifier: String
	/// The scope in which the moniker is unique.
	public let unique: UniquenessLevel
	/// The moniker kind, if known.
	public let kind: MonikerKind?
}

/// The response type for `textDocument/moniker`.
public typealias MonikerResponse = [Moniker]?
