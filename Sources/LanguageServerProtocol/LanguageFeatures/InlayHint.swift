import Foundation

/// Client capabilities for the `textDocument/inlayHint` request.
///
/// - Since: 3.17.0
public struct InlayHintClientCapabilities: Codable, Hashable, Sendable {
	/// Resolve support capabilities.
	public struct ResolveSupport: Codable, Hashable, Sendable {
		/// The properties that a client can resolve lazily.
		public var properties: [String]

		/// Creates an instance from its parts.
		public init(properties: [String]) {
			self.properties = properties
		}
	}

	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Indicates which properties a client can resolve lazily.
	public var resolveSupport: ResolveSupport?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool?, resolveSupport: ResolveSupport? = nil) {
		self.dynamicRegistration = dynamicRegistration
	}
}

/// Server capabilities for the inlay hint feature.
///
/// - Since: 3.17.0
public typealias InlayHintOptions = WorkDoneProgressOptions

/// Registration options for inlay hints.
///
/// - Since: 3.17.0
public struct InlayHintRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The id used to register the request, if any.
	public var id: String?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil, id: String? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
		self.id = id
	}
}

/// Workspace client capabilities specific to inlay hints.
///
/// - Since: 3.17.0
public struct InlayHintWorkspaceClientCapabilities: Codable, Hashable, Sendable {
	/// Whether the client supports a refresh request sent from the server.
	public var refreshSupport: Bool?

	/// Creates an instance from its parts.
	public init(refreshSupport: Bool? = nil) {
		self.refreshSupport = refreshSupport
	}
}

/// Parameters for the `textDocument/inlayHint` request.
///
/// - Since: 3.17.0
public struct InlayHintParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The visible document range for which inlay hints should be computed.
	public var range: LSPRange

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, textDocument: TextDocumentIdentifier, range: LSPRange
	) {
		self.workDoneToken = workDoneToken
		self.textDocument = textDocument
		self.range = range
	}
}

/// An inlay hint label part allows for interactive and composite labels.
///
/// - Since: 3.17.0
public struct InlayHintLabelPart: Codable, Hashable, Sendable {
	/// The value of this label part.
	public var value: String
	/// The tooltip text when hovering over this label part.
	public var tooltip: TwoTypeOption<String, MarkupContent>?
	/// An optional source code location that represents this label part.
	public var location: Location?
	/// An optional command for this label part.
	public var command: Command?

	/// Creates an instance from its parts.
	public init(
		value: String, tooltip: TwoTypeOption<String, MarkupContent>? = nil,
		location: Location? = nil, command: Command? = nil
	) {
		self.value = value
		self.tooltip = tooltip
		self.location = location
		self.command = command
	}
}

/// Inlay hint kinds.
///
/// - Since: 3.17.0
public enum InlayHintKind: Int, Codable, Hashable, Sendable {
	/// An inlay hint that is for a type annotation.
	case type = 1
	/// An inlay hint that is for a parameter.
	case parameter = 2
}

/// Inlay hint information.
///
/// - Since: 3.17.0
public struct InlayHint: Codable, Hashable, Sendable {
	/// The position of this hint.
	public var position: Position
	/// The label of this hint.
	public var label: TwoTypeOption<String, [InlayHintLabelPart]>
	/// The kind of this hint.
	public var kind: InlayHintKind?
	/// Optional text edits applied when accepting this inlay hint.
	public var textEdits: [TextEdit]?
	/// The tooltip text when hovering over this item.
	public var tooltip: TwoTypeOption<String, MarkupContent>?
	/// Render padding before the hint.
	public var paddingLeft: Bool?
	/// Render padding after the hint.
	public var paddingRight: Bool?
	/// A data entry field preserved on an inlay hint between request rounds.
	public var data: LSPAny?

	/// Creates an instance from its parts.
	public init(
		position: Position,
		label: TwoTypeOption<String, [InlayHintLabelPart]>,
		kind: InlayHintKind? = nil,
		textEdits: [TextEdit]? = nil,
		tooltip: TwoTypeOption<String, MarkupContent>? = nil,
		paddingLeft: Bool? = nil,
		paddingRight: Bool? = nil,
		data: LSPAny? = nil
	) {
		self.position = position
		self.label = label
		self.kind = kind
		self.textEdits = textEdits
		self.tooltip = tooltip
		self.paddingLeft = paddingLeft
		self.paddingRight = paddingRight
		self.data = data
	}
}

/// The response type for `textDocument/inlayHint`.
public typealias InlayHintResponse = [InlayHint]?
