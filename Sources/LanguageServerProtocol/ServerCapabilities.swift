import Foundation

/// Combined options for text document registration with static registration, work done progress, and position.
public struct StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions: Codable, Hashable,
	Sendable
{
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public var position: Position
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// The id used to register the request, if any.
	public var id: String?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil,
		textDocument: TextDocumentIdentifier,
		position: Position,
		documentSelector: DocumentSelector? = nil,
		id: String? = nil
	) {
		self.workDoneProgress = workDoneProgress
		self.textDocument = textDocument
		self.position = position
		self.documentSelector = documentSelector
		self.id = id
	}
}

/// Combined options for text document registration with work done progress and partial result support.
public struct PartialResultsWorkDoneProgressTextDocumentRegistrationOptions: Codable, Hashable,
	Sendable
{
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public var position: Position
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// An optional token that a server can use to report partial results.
	public var partialResultToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil,
		textDocument: TextDocumentIdentifier,
		position: Position,
		documentSelector: DocumentSelector? = nil,
		partialResultToken: ProgressToken? = nil
	) {
		self.workDoneProgress = workDoneProgress
		self.textDocument = textDocument
		self.position = position
		self.documentSelector = documentSelector
		self.partialResultToken = partialResultToken
	}
}

/// Options to signal work done progress support on the server side.
public struct WorkDoneProgressOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil) {
		self.workDoneProgress = workDoneProgress
	}
}

/// Options for save notifications.
public struct SaveOptions: Codable, Hashable, Sendable {
	/// Whether the client is supposed to include the content on save.
	public let includeText: Bool?

	/// Creates an instance from its parts.
	public init(includeText: Bool? = nil) {
		self.includeText = includeText
	}
}

/// Defines how the host (editor) should sync document changes to the language server.
public enum TextDocumentSyncKind: Int, Codable, Hashable, Sendable {
	/// Documents should not be synced at all.
	case none = 0
	/// Documents are synced by always sending the full content.
	case full = 1
	/// Documents are synced by sending incremental updates.
	case incremental = 2
}

/// Options for text document synchronization.
public struct TextDocumentSyncOptions: Codable, Hashable, Sendable {
	/// Whether open and close notifications are sent to the server.
	public var openClose: Bool?
	/// How documents are synced: none, full, or incremental.
	public var change: TextDocumentSyncKind?
	/// Whether `willSave` notifications are sent.
	public var willSave: Bool?
	/// Whether `willSaveWaitUntil` requests are supported.
	public var willSaveWaitUntil: Bool?
	/// Whether save notifications are sent, with optional configuration.
	public var save: TwoTypeOption<Bool, SaveOptions>?

	/// The resolved save options regardless of whether `save` was a bool or an options object.
	public var effectiveSave: SaveOptions? {
		switch save {
		case nil:
			return nil
		case .optionA(let value):
			return value ? SaveOptions(includeText: false) : nil
		case .optionB(let options):
			return options
		}
	}

	/// Creates an instance from its parts.
	public init(
		openClose: Bool? = nil, change: TextDocumentSyncKind? = nil, willSave: Bool? = nil,
		willSaveWaitUntil: Bool? = nil, save: TwoTypeOption<Bool, SaveOptions>? = nil
	) {
		self.openClose = openClose
		self.change = change
		self.willSave = willSave
		self.willSaveWaitUntil = willSaveWaitUntil
		self.save = save
	}

}

/// Server capabilities for completion requests.
public struct CompletionOptions: Codable, Hashable, Sendable {
	/// Server capabilities specific to `CompletionItem`.
	///
	/// - Since: 3.17.0
	public struct CompletionItem: Codable, Hashable, Sendable {
		/// Whether the server supports label details.
		///
		/// - Since: 3.17.0
		public var labelDetailsSupport: Bool?

		/// Creates an instance from its parts.
		public init(labelDetailsSupport: Bool?) {
			self.labelDetailsSupport = labelDetailsSupport
		}
	}

	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The characters that trigger completion automatically, if any.
	public var triggerCharacters: [String]?
	/// The default commit characters for all completion items, if any.
	///
	/// - Since: 3.2.0
	public var allCommitCharacters: [String]?
	/// Whether the server supports resolving additional completion item properties.
	public var resolveProvider: Bool?
	/// Server capabilities specific to completion items, if any.
	///
	/// - Since: 3.17.0
	public var completionItem: CompletionItem?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool,
		triggerCharacters: [String]?,
		allCommitCharacters: [String]?,
		resolveProvider: Bool,
		completionItem: CompletionItem?
	) {
		self.workDoneProgress = workDoneProgress
		self.triggerCharacters = triggerCharacters
		self.allCommitCharacters = allCommitCharacters
		self.resolveProvider = resolveProvider
		self.completionItem = completionItem
	}
}

/// Server capabilities for hover requests.
public typealias HoverOptions = WorkDoneProgressOptions

/// Server capabilities for signature help requests.
public struct SignatureHelpOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The characters that trigger signature help automatically, if any.
	public var triggerCharacters: [String]?
	/// The characters that re-trigger signature help when already active, if any.
	///
	/// - Since: 3.15.0
	public var retriggerCharacters: [String]?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil,
		triggerCharacters: [String]? = nil,
		retriggerCharacters: [String]? = nil
	) {
		self.workDoneProgress = workDoneProgress
		self.triggerCharacters = triggerCharacters
		self.retriggerCharacters = retriggerCharacters
	}
}

/// Server capabilities for declaration requests.
///
/// - Since: 3.14.0
public typealias DeclarationOptions = WorkDoneProgressOptions

/// Registration options for declaration requests.
///
/// - Since: 3.14.0
public typealias DeclarationRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for definition requests.
public typealias DefinitionOptions = WorkDoneProgressOptions

/// Server capabilities for type definition requests.
public typealias TypeDefinitionOptions = WorkDoneProgressOptions

/// Registration options for type definition requests.
public typealias TypeDefinitionRegistrationOptions =
	PartialResultsWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for implementation requests.
public typealias ImplementationOptions = WorkDoneProgressOptions

/// Registration options for implementation requests.
public typealias ImplementationRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for find references requests.
public typealias ReferenceOptions = WorkDoneProgressOptions

/// Server capabilities for document symbol requests.
public struct DocumentSymbolOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// A human-readable string shown when multiple outlines trees are shown for the same document.
	public var label: String?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, label: String? = nil) {
		self.workDoneProgress = workDoneProgress
		self.label = label
	}
}

/// Server capabilities for document color requests.
public typealias DocumentColorOptions = WorkDoneProgressOptions

/// Registration options for document color requests.
public typealias DocumentColorRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for document formatting requests.
public typealias DocumentFormattingOptions = WorkDoneProgressOptions

/// Server capabilities for document range formatting requests.
public typealias DocumentRangeFormattingOptions = WorkDoneProgressOptions

/// Server capabilities for on-type formatting.
public struct DocumentOnTypeFormattingOptions: Codable, Hashable, Sendable {
	/// A character on which formatting should be triggered.
	public var firstTriggerCharacter: String
	/// More trigger characters, if any.
	public var moreTriggerCharacter: [String]?

	/// Creates an instance from its parts.
	public init(
		firstTriggerCharacter: String,
		moreTriggerCharacter: [String]? = nil
	) {
		self.firstTriggerCharacter = firstTriggerCharacter
		self.moreTriggerCharacter = moreTriggerCharacter
	}
}

/// Server capabilities for folding range requests.
public typealias FoldingRangeOptions = WorkDoneProgressOptions

/// Registration options for folding range requests.
public typealias FoldingRangeRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for linked editing range requests.
///
/// - Since: 3.16.0
public typealias LinkedEditingRangeOptions = WorkDoneProgressOptions

/// Registration options for linked editing range requests.
///
/// - Since: 3.16.0
public typealias LinkedEditingRangeRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The legend describing token types and modifiers.
	public var legend: SemanticTokensLegend
	/// Whether the server supports range requests.
	public var range: SemanticTokensClientCapabilities.Requests.RangeOption?
	/// Whether the server supports full document requests.
	public var full: SemanticTokensClientCapabilities.Requests.FullOption?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil, legend: SemanticTokensLegend,
		range: SemanticTokensClientCapabilities.Requests.RangeOption? = nil,
		full: SemanticTokensClientCapabilities.Requests.FullOption? = nil
	) {
		self.workDoneProgress = workDoneProgress
		self.legend = legend
		self.range = range
		self.full = full
	}
}

/// Registration options for semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// The legend describing token types and modifiers.
	public var legend: SemanticTokensLegend
	/// Whether the server supports range requests.
	public var range: SemanticTokensClientCapabilities.Requests.RangeOption?
	/// Whether the server supports full document requests.
	public var full: SemanticTokensClientCapabilities.Requests.FullOption?
	/// The id used to register the request, if any.
	public var id: String?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil, workDoneProgress: Bool? = nil,
		legend: SemanticTokensLegend,
		range: SemanticTokensClientCapabilities.Requests.RangeOption? = nil,
		full: SemanticTokensClientCapabilities.Requests.FullOption? = nil, id: String? = nil
	) {
		self.documentSelector = documentSelector
		self.workDoneProgress = workDoneProgress
		self.legend = legend
		self.range = range
		self.full = full
		self.id = id
	}
}

/// Server capabilities for moniker requests.
///
/// - Since: 3.16.0
public typealias MonikerOptions = WorkDoneProgressOptions

/// Registration options for moniker requests.
///
/// - Since: 3.16.0
public typealias MonikerRegistrationOptions =
	PartialResultsWorkDoneProgressTextDocumentRegistrationOptions

/// Server capabilities for workspace folders.
public struct WorkspaceFoldersServerCapabilities: Codable, Hashable, Sendable {
	/// Whether the server supports workspace folders.
	public var supported: Bool?
	/// Whether the server wants to receive workspace folder change notifications.
	public var changeNotifications: TwoTypeOption<String, Bool>?

	/// Creates an instance from its parts.
	public init(
		supported: Bool? = nil,
		changeNotifications: TwoTypeOption<String, Bool>? = nil
	) {
		self.supported = supported
		self.changeNotifications = changeNotifications
	}
}

/// The capabilities the language server provides.
public struct ServerCapabilities: Codable, Hashable, Sendable {
	/// Workspace specific server capabilities.
	public struct Workspace: Codable, Hashable, Sendable {
		/// Server capabilities for file operations.
		///
		/// - Since: 3.16.0
		public struct FileOperations: Codable, Hashable, Sendable {
			/// The server is interested in receiving `didCreateFiles` notifications.
			public var didCreate: FileOperationRegistrationOptions?
			/// The server is interested in receiving `willCreateFiles` requests.
			public var willCreate: FileOperationRegistrationOptions?
			/// The server is interested in receiving `didRenameFiles` notifications.
			public var didRename: FileOperationRegistrationOptions?
			/// The server is interested in receiving `willRenameFiles` requests.
			public var willRename: FileOperationRegistrationOptions?
			/// The server is interested in receiving `didDeleteFiles` notifications.
			public var didDelete: FileOperationRegistrationOptions?
			/// The server is interested in receiving `willDeleteFiles` requests.
			public var willDelete: FileOperationRegistrationOptions?

			/// Creates an instance from its parts.
			public init(
				didCreate: FileOperationRegistrationOptions? = nil,
				willCreate: FileOperationRegistrationOptions? = nil,
				didRename: FileOperationRegistrationOptions? = nil,
				willRename: FileOperationRegistrationOptions? = nil,
				didDelete: FileOperationRegistrationOptions? = nil,
				willDelete: FileOperationRegistrationOptions? = nil
			) {
				self.didCreate = didCreate
				self.willCreate = willCreate
				self.didRename = didRename
				self.willRename = willRename
				self.didDelete = didDelete
				self.willDelete = willDelete
			}
		}

		/// Workspace folder server capabilities, if any.
		public var workspaceFolders: WorkspaceFoldersServerCapabilities?
		/// File operation server capabilities, if any.
		public var fileOperations: FileOperations?

		/// Creates an instance from its parts.
		public init(
			workspaceFolders: WorkspaceFoldersServerCapabilities? = nil,
			fileOperations: FileOperations? = nil
		) {
			self.workspaceFolders = workspaceFolders
			self.fileOperations = fileOperations
		}
	}

	/// How text documents are synced, if supported.
	public var textDocumentSync: TwoTypeOption<TextDocumentSyncOptions, TextDocumentSyncKind>?
	/// The server provides completion support, if any.
	public var completionProvider: CompletionOptions?
	/// The server provides hover support.
	public var hoverProvider: TwoTypeOption<Bool, HoverOptions>?
	/// The server provides signature help support, if any.
	public var signatureHelpProvider: SignatureHelpOptions?
	/// The server provides go to declaration support.
	public var declarationProvider:
		ThreeTypeOption<Bool, DeclarationOptions, DeclarationRegistrationOptions>?
	/// The server provides go to definition support.
	public var definitionProvider: TwoTypeOption<Bool, DefinitionOptions>?
	/// The server provides go to type definition support.
	public var typeDefinitionProvider:
		ThreeTypeOption<Bool, TypeDefinitionOptions, TypeDefinitionRegistrationOptions>?
	/// The server provides go to implementation support.
	public var implementationProvider:
		ThreeTypeOption<Bool, ImplementationOptions, ImplementationRegistrationOptions>?
	/// The server provides find references support.
	public var referencesProvider: TwoTypeOption<Bool, ReferenceOptions>?
	/// The server provides document highlight support.
	public var documentHighlightProvider: TwoTypeOption<Bool, DocumentHighlightOptions>?
	/// The server provides document symbol support.
	public var documentSymbolProvider: TwoTypeOption<Bool, DocumentSymbolOptions>?
	/// The server provides code actions.
	public var codeActionProvider: TwoTypeOption<Bool, CodeActionOptions>?
	/// The server provides code lens, if any.
	public var codeLensProvider: CodeLensOptions?
	/// The server provides document link support, if any.
	public var documentLinkProvider: DocumentLinkOptions?
	/// The server provides color provider support.
	public var colorProvider:
		ThreeTypeOption<Bool, DocumentColorOptions, DocumentColorRegistrationOptions>?
	/// The server provides document formatting.
	public var documentFormattingProvider: TwoTypeOption<Bool, DocumentFormattingOptions>?
	/// The server provides document range formatting.
	public var documentRangeFormattingProvider: TwoTypeOption<Bool, DocumentRangeFormattingOptions>?
	/// The server provides document on-type formatting, if any.
	public var documentOnTypeFormattingProvider: DocumentOnTypeFormattingOptions?
	/// The server provides rename support.
	public var renameProvider: TwoTypeOption<Bool, RenameOptions>?
	/// The server provides folding range support.
	public var foldingRangeProvider:
		ThreeTypeOption<Bool, FoldingRangeOptions, FoldingRangeRegistrationOptions>?
	/// The server provides execute command support, if any.
	public var executeCommandProvider: ExecuteCommandOptions?
	/// The server provides selection range support.
	public var selectionRangeProvider:
		ThreeTypeOption<Bool, SelectionRangeOptions, SelectionRangeRegistrationOptions>?
	/// The server provides linked editing range support.
	public var linkedEditingRangeProvider:
		ThreeTypeOption<Bool, LinkedEditingRangeOptions, LinkedEditingRangeRegistrationOptions>?
	/// The server provides call hierarchy support.
	public var callHierarchyProvider:
		ThreeTypeOption<Bool, CallHierarchyOptions, CallHierarchyRegistrationOptions>?
	/// The server provides semantic tokens support.
	public var semanticTokensProvider:
		TwoTypeOption<SemanticTokensOptions, SemanticTokensRegistrationOptions>?
	/// The server provides moniker support.
	public var monikerProvider: ThreeTypeOption<Bool, MonikerOptions, MonikerRegistrationOptions>?
	/// The server provides type hierarchy support.
	public var typeHierarchyProvider:
		ThreeTypeOption<Bool, TypeHierarchyOptions, TypeHierarchyRegistrationOptions>?
	/// The server provides inlay hint support.
	public var inlayHintProvider:
		ThreeTypeOption<Bool, InlayHintOptions, InlayHintRegistrationOptions>?
	/// The server provides pull diagnostics support.
	public var diagnosticProvider: TwoTypeOption<DiagnosticOptions, DiagnosticRegistrationOptions>?
	/// The server provides workspace symbol support.
	public var workspaceSymbolProvider: TwoTypeOption<Bool, WorkspaceSymbolOptions>?
	/// Workspace specific server capabilities, if any.
	public var workspace: Workspace?
	/// Experimental server capabilities, if any.
	public var experimental: LSPAny?

	/// Creates an instance with no capabilities set.
	public init() {
	}
}
