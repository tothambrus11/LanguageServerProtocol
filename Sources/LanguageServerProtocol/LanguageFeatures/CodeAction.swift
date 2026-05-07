import Foundation

/// The kind of a code action.
public typealias CodeActionKind = String

extension CodeActionKind {
	/// Empty kind.
	public static let Empty: CodeActionKind = ""
	/// Base kind for quickfix actions.
	public static let Quickfix: CodeActionKind = "quickfix"
	/// Base kind for refactoring actions.
	public static let Refactor: CodeActionKind = "refactor"
	/// Base kind for refactoring extraction actions.
	public static let RefactorExtract: CodeActionKind = "refactor.extract"
	/// Base kind for refactoring inline actions.
	public static let RefactorInline: CodeActionKind = "refactor.inline"
	/// Base kind for refactoring rewrite actions.
	public static let RefactorRewrite: CodeActionKind = "refactor.rewrite"
	/// Base kind for source actions.
	public static let Source: CodeActionKind = "source"
	/// Base kind for organize imports source actions.
	public static let SourceOrganizeImports: CodeActionKind = "source.organizeImports"
	/// Base kind for fix-all source actions.
	///
	/// - Since: 3.17.0
	public static let SourceFixAll: CodeActionKind = "source.fixAll"
}

/// Client capabilities for the `textDocument/codeAction` request.
public struct CodeActionClientCapabilities: Codable, Hashable, Sendable {
	/// Capabilities for code action literal support.
	public struct CodeActionLiteralSupport: Codable, Hashable, Sendable {
		/// The code action kind values the client supports.
		public var codeActionKind: ValueSet<CodeActionKind>

		/// Creates an instance from its parts.
		public init(codeActionKind: ValueSet<CodeActionKind>) {
			self.codeActionKind = codeActionKind
		}
	}

	/// Capabilities for resolve support.
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
	/// Capabilities for code action literal support.
	public var codeActionLiteralSupport: CodeActionLiteralSupport?
	/// Whether the client supports the `isPreferred` property.
	///
	/// - Since: 3.15.0
	public var isPreferredSupport: Bool?
	/// Whether the client supports the `disabled` property.
	///
	/// - Since: 3.16.0
	public var disabledSupport: Bool?
	/// Whether the client supports the `data` property.
	///
	/// - Since: 3.16.0
	public var dataSupport: Bool?
	/// Indicates which properties a client can resolve lazily.
	///
	/// - Since: 3.16.0
	public var resolveSupport: ResolveSupport?
	/// Whether the client honors change annotations.
	///
	/// - Since: 3.16.0
	public var honorsChangeAnnotations: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool?,
		codeActionLiteralSupport: CodeActionClientCapabilities.CodeActionLiteralSupport? = nil,
		isPreferredSupport: Bool? = nil,
		disabledSupport: Bool? = nil,
		dataSupport: Bool? = nil,
		resolveSupport: ResolveSupport? = nil,
		honorsChangeAnnotations: Bool? = nil
	) {
		self.dynamicRegistration = dynamicRegistration
		self.codeActionLiteralSupport = codeActionLiteralSupport
		self.isPreferredSupport = isPreferredSupport
		self.disabledSupport = disabledSupport
		self.dataSupport = dataSupport
		self.resolveSupport = resolveSupport
		self.honorsChangeAnnotations = honorsChangeAnnotations
	}
}

/// Server capabilities for the `textDocument/codeAction` request.
public struct CodeActionOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The kinds of code actions the server supports.
	public var codeActionKinds: [CodeActionKind]?
	/// Whether the server supports resolving additional code action properties.
	///
	/// - Since: 3.16.0
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool?, codeActionKinds: [CodeActionKind]?, resolveProvider: Bool)
	{
		self.workDoneProgress = workDoneProgress
		self.codeActionKinds = codeActionKinds
		self.resolveProvider = resolveProvider
	}
}

/// The reason why code actions were requested.
///
/// - Since: 3.17.0
public enum CodeActionTriggerKind: Int, Codable, Hashable, Sendable {
	/// Code actions were explicitly requested by the user or an extension.
	case invoked = 1
	/// Code actions were requested automatically.
	case automatic = 2
}

/// Contains additional diagnostic information about the context in which a code action is run.
public struct CodeActionContext: Codable, Hashable, Sendable {
	/// An array of diagnostics known on the client side overlapping the range.
	public let diagnostics: [Diagnostic]
	/// Requested kind of actions to return, if specified.
	public let only: [CodeActionKind]?
	/// The reason why code actions were requested.
	///
	/// - Since: 3.17.0
	public let triggerKind: CodeActionTriggerKind?

	/// Creates an instance from its parts.
	public init(
		diagnostics: [Diagnostic], only: [CodeActionKind]?,
		triggerKind: CodeActionTriggerKind? = nil
	) {
		self.diagnostics = diagnostics
		self.only = only
		self.triggerKind = triggerKind
	}
}

/// Parameters for the `textDocument/codeAction` request.
public struct CodeActionParams: Codable, Hashable, Sendable {
	/// The document in which the command was invoked.
	public let textDocument: TextDocumentIdentifier
	/// The range for which the command was invoked.
	public let range: LSPRange
	/// Context carrying additional information.
	public let context: CodeActionContext

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, range: LSPRange, context: CodeActionContext) {
		self.textDocument = textDocument
		self.range = range
		self.context = context
	}
}

/// A code action represents a change that can be performed in code.
public struct CodeAction: Codable, Hashable, Sendable {
	/// Marks the code action as disabled.
	public struct Disabled: Codable, Hashable, Sendable {
		/// Whether the code action is disabled.
		public var disabled: Bool
	}

	/// A short, human-readable title for this code action.
	public var title: String
	/// The kind of the code action.
	public var kind: CodeActionKind?
	/// The diagnostics that this code action resolves.
	public var diagnostics: [Diagnostic]?
	/// Marks this as a preferred action.
	///
	/// - Since: 3.15.0
	public var isPreferred: Bool?
	/// Marks that the code action cannot currently be applied.
	///
	/// - Since: 3.16.0
	public var disabled: Disabled?
	/// The workspace edit this code action performs.
	public var edit: WorkspaceEdit?
	/// A command this code action executes.
	public var command: Command?
	/// A data entry field that is preserved on a code action between request rounds.
	///
	/// - Since: 3.16.0
	public var data: LSPAny?

	/// Creates an instance from its parts.
	public init(
		title: String, kind: CodeActionKind? = nil, diagnostics: [Diagnostic]? = nil,
		isPreferred: Bool? = nil, disabled: CodeAction.Disabled? = nil, edit: WorkspaceEdit? = nil,
		command: Command? = nil, data: LSPAny? = nil
	) {
		self.title = title
		self.kind = kind
		self.diagnostics = diagnostics
		self.isPreferred = isPreferred
		self.disabled = disabled
		self.edit = edit
		self.command = command
		self.data = data
	}
}

/// The response type for `textDocument/codeAction`.
public typealias CodeActionResponse = [TwoTypeOption<Command, CodeAction>]?
