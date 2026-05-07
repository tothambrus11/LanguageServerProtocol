import Foundation

/// A client capability that indicates dynamic registration support.
public struct DynamicRegistrationClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool) {
		self.dynamicRegistration = dynamicRegistration
	}
}

/// A client capability that indicates dynamic registration and link support.
public struct DynamicRegistrationLinkSupportClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Whether the client supports `LocationLink` responses.
	public var linkSupport: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool, linkSupport: Bool) {
		self.dynamicRegistration = dynamicRegistration
		self.linkSupport = linkSupport
	}
}

/// The kind of resource operation supported by the client.
public enum ResourceOperationKind: String, Codable, Hashable, Sendable {
	/// Creating resources.
	case create
	/// Renaming resources.
	case rename
	/// Deleting resources.
	case delete
}

/// How the client handles workspace edit failures.
public enum FailureHandlingKind: String, Codable, Hashable, Sendable {
	/// Applying the workspace edit is simply aborted if one of the changes fails.
	case abort
	/// All operations are executed transactionally; they all succeed or all fail.
	case transactional
	/// Text-only changes are applied transactionally; other changes are aborted.
	case textOnlyTransactional
	/// The client tries to undo already-applied changes.
	case undo
}

/// Client capabilities for workspace edits.
public struct WorkspaceClientCapabilityEdit: Codable, Hashable, Sendable {
	/// Whether the client supports versioned document changes.
	public let documentChanges: Bool?
	/// The resource operations the client supports.
	public let resourceOperations: [ResourceOperationKind]?
	/// The failure handling strategy the client uses.
	public let failureHandling: FailureHandlingKind?

	/// Creates an instance from its parts.
	public init(
		documentChanges: Bool?,
		resourceOperations: [ResourceOperationKind]?,
		failureHandling: FailureHandlingKind?
	) {
		self.documentChanges = documentChanges
		self.resourceOperations = resourceOperations
		self.failureHandling = failureHandling
	}
}

/// Client capabilities for `workspace/didChangeConfiguration`.
public typealias DidChangeConfigurationClientCapabilities = GenericDynamicRegistration

/// Client capabilities for `workspace/didChangeWatchedFiles`.
public typealias DidChangeWatchedFilesClientCapabilities = GenericDynamicRegistration

/// Client capabilities for the `window/showDocument` request.
public struct ShowDocumentClientCapabilities: Hashable, Codable, Sendable {
	/// Whether the client has support for the show document request.
	public var support: Bool

	/// Creates an instance from its parts.
	public init(support: Bool) {
		self.support = support
	}
}

/// Client capabilities for the `window/showMessageRequest` request.
public struct ShowMessageRequestClientCapabilities: Hashable, Codable, Sendable {
	/// Capabilities specific to the `MessageActionItem` type.
	public struct MessageActionItemCapabilities: Hashable, Codable, Sendable {
		/// Whether the client supports additional attributes which are preserved and sent back to the server.
		public var additionalPropertiesSupport: Bool?

		/// Creates an instance from its parts.
		public init(additionalPropertiesSupport: Bool?) {
			self.additionalPropertiesSupport = additionalPropertiesSupport
		}
	}

	/// Capabilities specific to `MessageActionItem`, if any.
	public var messageActionItem: MessageActionItemCapabilities?

	/// Creates an instance from its parts.
	public init(messageActionItem: MessageActionItemCapabilities?) {
		self.messageActionItem = messageActionItem
	}
}

/// Client capabilities for the window.
public struct WindowClientCapabilities: Hashable, Codable, Sendable {
	/// Whether the client supports the `window/workDoneProgress/create` request.
	public var workDoneProgress: Bool?
	/// Capabilities for the `window/showMessageRequest` method.
	public var showMessage: ShowMessageRequestClientCapabilities?
	/// Capabilities for the `window/showDocument` method.
	public var showDocument: ShowDocumentClientCapabilities?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool,
		showMessage: ShowMessageRequestClientCapabilities?,
		showDocument: ShowDocumentClientCapabilities?
	) {
		self.workDoneProgress = workDoneProgress
		self.showMessage = showMessage
		self.showDocument = showDocument
	}
}

/// Client capabilities specific to regular expressions.
public struct RegularExpressionsClientCapabilities: Hashable, Codable, Sendable {
	/// The engine's name.
	public var engine: String
	/// The engine's version, if any.
	public var version: String?

	/// Creates an instance from its parts.
	public init(engine: String, version: String? = nil) {
		self.engine = engine
		self.version = version
	}
}

/// Client capabilities for rendering Markdown content.
public struct MarkdownClientCapabilities: Hashable, Codable, Sendable {
	/// The name of the Markdown parser.
	public var parser: String
	/// The version of the parser, if any.
	public var version: String?
	/// The list of HTML tags the client allows in Markdown, if any.
	public var allowedTags: [String]?

	/// Creates an instance from its parts.
	public init(parser: String, version: String? = nil, allowedTags: [String]? = nil) {
		self.parser = parser
		self.version = version
		self.allowedTags = allowedTags
	}
}

/// General client capabilities.
public struct GeneralClientCapabilities: Hashable, Codable, Sendable {
	/// Client capabilities for regular expressions.
	public var regularExpressions: RegularExpressionsClientCapabilities?
	/// Client capabilities for Markdown rendering.
	public var markdown: MarkdownClientCapabilities?

	/// Creates an instance from its parts.
	public init(
		regularExpressions: RegularExpressionsClientCapabilities?,
		markdown: MarkdownClientCapabilities?
	) {
		self.regularExpressions = regularExpressions
		self.markdown = markdown
	}
}

/// Client capabilities for text document synchronization.
public struct TextDocumentSyncClientCapabilities: Codable, Hashable, Sendable {
	/// Whether text document synchronization supports dynamic registration.
	public let dynamicRegistration: Bool?
	/// Whether the client supports the `willSave` notification.
	public let willSave: Bool?
	/// Whether the client supports the `willSaveWaitUntil` request.
	public let willSaveWaitUntil: Bool?
	/// Whether the client supports the `didSave` notification.
	public let didSave: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool, willSave: Bool, willSaveWaitUntil: Bool, didSave: Bool) {
		self.dynamicRegistration = dynamicRegistration
		self.willSave = willSave
		self.willSaveWaitUntil = willSaveWaitUntil
		self.didSave = didSave
	}
}

/// Text document specific client capabilities.
public struct TextDocumentClientCapabilities: Codable, Hashable, Sendable {
	/// Capabilities for text document synchronization.
	public var synchronization: TextDocumentSyncClientCapabilities?
	/// Capabilities for `textDocument/completion`.
	public var completion: CompletionClientCapabilities?
	/// Capabilities for `textDocument/hover`.
	public var hover: HoverClientCapabilities?
	/// Capabilities for `textDocument/signatureHelp`.
	public var signatureHelp: SignatureHelpClientCapabilities?
	/// Capabilities for `textDocument/declaration`.
	public var declaration: DeclarationClientCapabilities?
	/// Capabilities for `textDocument/definition`.
	public var definition: DefinitionClientCapabilities?
	/// Capabilities for `textDocument/typeDefinition`.
	public var typeDefinition: TypeDefinitionClientCapabilities?
	/// Capabilities for `textDocument/implementation`.
	public var implementation: ImplementationClientCapabilities?
	/// Capabilities for `textDocument/references`.
	public var references: ReferenceClientCapabilities?
	/// Capabilities for `textDocument/documentHighlight`.
	public var documentHighlight: DocumentHighlightClientCapabilities?
	/// Capabilities for `textDocument/documentSymbol`.
	public var documentSymbol: DocumentSymbolClientCapabilities?
	/// Capabilities for `textDocument/codeAction`.
	public var codeAction: CodeActionClientCapabilities?
	/// Capabilities for `textDocument/codeLens`.
	public var codeLens: CodeLensClientCapabilities?
	/// Capabilities for `textDocument/documentLink`.
	public var documentLink: DocumentLinkClientCapabilities?
	/// Capabilities for `textDocument/documentColor`.
	public var colorProvider: DocumentColorClientCapabilities?
	/// Capabilities for `textDocument/formatting`.
	public var formatting: DocumentFormattingClientCapabilities?
	/// Capabilities for `textDocument/rangeFormatting`.
	public var rangeFormatting: DocumentRangeFormattingClientCapabilities?
	/// Capabilities for `textDocument/onTypeFormatting`.
	public var onTypeFormatting: DocumentOnTypeFormattingClientCapabilities?
	/// Capabilities for `textDocument/rename`.
	public var rename: RenameClientCapabilities?
	/// Capabilities for `textDocument/publishDiagnostics`.
	public var publishDiagnostics: PublishDiagnosticsClientCapabilities?
	/// Capabilities for `textDocument/foldingRange`.
	public var foldingRange: FoldingRangeClientCapabilities?
	/// Capabilities for `textDocument/selectionRange`.
	public var selectionRange: SelectionRangeClientCapabilities?
	/// Capabilities for `textDocument/linkedEditingRange`.
	public var linkedEditingRange: LinkedEditingRangeClientCapabilities?
	/// Capabilities for `textDocument/prepareCallHierarchy`.
	public var callHierarchy: CallHierarchyClientCapabilities?
	/// Capabilities for `textDocument/semanticTokens`.
	public var semanticTokens: SemanticTokensClientCapabilities?
	/// Capabilities for `textDocument/moniker`.
	public var moniker: MonikerClientCapabilities?
	/// Capabilities for `textDocument/inlayHint`.
	public var inlayHint: InlayHintClientCapabilities?
	/// Capabilities for `textDocument/diagnostic`.
	public var diagnostic: DiagnosticClientCapabilities?

	/// Creates an instance from its parts.
	public init(
		synchronization: TextDocumentSyncClientCapabilities? = nil,
		completion: CompletionClientCapabilities? = nil,
		hover: HoverClientCapabilities? = nil,
		signatureHelp: SignatureHelpClientCapabilities? = nil,
		declaration: DeclarationClientCapabilities? = nil,
		definition: DefinitionClientCapabilities? = nil,
		typeDefinition: TypeDefinitionClientCapabilities? = nil,
		implementation: ImplementationClientCapabilities? = nil,
		references: ReferenceClientCapabilities? = nil,
		documentHighlight: DocumentHighlightClientCapabilities? = nil,
		documentSymbol: DocumentSymbolClientCapabilities? = nil,
		codeAction: CodeActionClientCapabilities? = nil,
		codeLens: CodeLensClientCapabilities? = nil,
		documentLink: DocumentLinkClientCapabilities? = nil,
		colorProvider: DocumentColorClientCapabilities? = nil,
		formatting: DocumentFormattingClientCapabilities? = nil,
		rangeFormatting: DocumentRangeFormattingClientCapabilities? = nil,
		onTypeFormatting: DocumentOnTypeFormattingClientCapabilities? = nil,
		rename: RenameClientCapabilities? = nil,
		publishDiagnostics: PublishDiagnosticsClientCapabilities? = nil,
		foldingRange: FoldingRangeClientCapabilities? = nil,
		selectionRange: SelectionRangeClientCapabilities? = nil,
		linkedEditingRange: LinkedEditingRangeClientCapabilities? = nil,
		callHierarchy: CallHierarchyClientCapabilities? = nil,
		semanticTokens: SemanticTokensClientCapabilities? = nil,
		moniker: MonikerClientCapabilities? = nil,
		inlayHint: InlayHintClientCapabilities? = nil,
		diagnostic: DiagnosticClientCapabilities? = nil
	) {
		self.synchronization = synchronization
		self.completion = completion
		self.hover = hover
		self.signatureHelp = signatureHelp
		self.declaration = declaration
		self.definition = definition
		self.typeDefinition = typeDefinition
		self.implementation = implementation
		self.references = references
		self.documentHighlight = documentHighlight
		self.documentSymbol = documentSymbol
		self.codeAction = codeAction
		self.codeLens = codeLens
		self.documentLink = documentLink
		self.colorProvider = colorProvider
		self.formatting = formatting
		self.rangeFormatting = rangeFormatting
		self.onTypeFormatting = onTypeFormatting
		self.rename = rename
		self.publishDiagnostics = publishDiagnostics
		self.foldingRange = foldingRange
		self.selectionRange = selectionRange
		self.linkedEditingRange = linkedEditingRange
		self.callHierarchy = callHierarchy
		self.semanticTokens = semanticTokens
		self.moniker = moniker
		self.diagnostic = diagnostic
	}
}

/// The capabilities provided by the client (editor or tool).
public struct ClientCapabilities: Codable, Hashable, Sendable {
	/// Workspace specific client capabilities.
	public struct Workspace: Codable, Hashable, Sendable {
		/// Client capabilities for file operations.
		public struct FileOperations: Codable, Hashable, Sendable {
			/// Whether dynamic registration is supported.
			public var dynamicRegistration: Bool?
			/// The client supports `didCreateFiles` notifications.
			public var didCreate: Bool?
			/// The client supports `willCreateFiles` requests.
			public var willCreate: Bool?
			/// The client supports `didRenameFiles` notifications.
			public var didRename: Bool?
			/// The client supports `willRenameFiles` requests.
			public var willRename: Bool?
			/// The client supports `didDeleteFiles` notifications.
			public var didDelete: Bool?
			/// The client supports `willDeleteFiles` requests.
			public var willDelete: Bool?

			/// Creates an instance from its parts.
			public init(
				dynamicRegistration: Bool? = nil,
				didCreate: Bool? = nil,
				willCreate: Bool? = nil,
				didRename: Bool? = nil,
				willRename: Bool? = nil,
				didDelete: Bool? = nil,
				willDelete: Bool? = nil
			) {
				self.dynamicRegistration = dynamicRegistration
				self.didCreate = didCreate
				self.willCreate = willCreate
				self.didRename = didRename
				self.willRename = willRename
				self.didDelete = didDelete
				self.willDelete = willDelete
			}
		}

		/// Whether the client supports applying batch edits to the workspace.
		public let applyEdit: Bool?
		/// Capabilities for `WorkspaceEdit`.
		public let workspaceEdit: WorkspaceClientCapabilityEdit?
		/// Capabilities for `workspace/didChangeConfiguration`.
		public let didChangeConfiguration: DidChangeConfigurationClientCapabilities?
		/// Capabilities for `workspace/didChangeWatchedFiles`.
		public let didChangeWatchedFiles: GenericDynamicRegistration?
		/// Capabilities for `workspace/symbol`.
		public let symbol: WorkspaceSymbolClientCapabilities?
		/// Capabilities for `workspace/executeCommand`.
		public let executeCommand: GenericDynamicRegistration?
		/// Whether the client supports workspace folders.
		public let workspaceFolders: Bool?
		/// Whether the client supports `workspace/configuration` requests.
		public let configuration: Bool?
		/// Capabilities for workspace semantic tokens.
		public let semanticTokens: SemanticTokensWorkspaceClientCapabilities?
		/// Capabilities for workspace code lens.
		public let codeLens: CodeLensWorkspaceClientCapabilities?
		/// Capabilities for file operations.
		public let fileOperations: FileOperations?

		/// Creates an instance from its parts.
		public init(
			applyEdit: Bool,
			workspaceEdit: WorkspaceClientCapabilityEdit?,
			didChangeConfiguration: DidChangeConfigurationClientCapabilities?,
			didChangeWatchedFiles: GenericDynamicRegistration?,
			symbol: WorkspaceSymbolClientCapabilities?,
			executeCommand: GenericDynamicRegistration?,
			workspaceFolders: Bool?,
			configuration: Bool?,
			semanticTokens: SemanticTokensWorkspaceClientCapabilities?,
			codeLens: CodeLensWorkspaceClientCapabilities? = nil,
			fileOperations: FileOperations? = nil
		) {
			self.applyEdit = applyEdit
			self.workspaceEdit = workspaceEdit
			self.didChangeConfiguration = didChangeConfiguration
			self.didChangeWatchedFiles = didChangeWatchedFiles
			self.symbol = symbol
			self.executeCommand = executeCommand
			self.workspaceFolders = workspaceFolders
			self.configuration = configuration
			self.semanticTokens = semanticTokens
			self.codeLens = codeLens
			self.fileOperations = fileOperations
		}
	}

	/// Workspace specific capabilities.
	public let workspace: Workspace?
	/// Text document specific capabilities.
	public let textDocument: TextDocumentClientCapabilities?
	/// Window specific capabilities.
	public var window: WindowClientCapabilities?
	/// General client capabilities.
	public var general: GeneralClientCapabilities?
	/// Experimental client capabilities.
	public let experimental: LSPAny?

	/// Creates an instance from its parts.
	public init(
		workspace: Workspace?, textDocument: TextDocumentClientCapabilities?,
		window: WindowClientCapabilities?, general: GeneralClientCapabilities?,
		experimental: LSPAny?
	) {
		self.workspace = workspace
		self.textDocument = textDocument
		self.window = window
		self.general = general
		self.experimental = experimental
	}
}
