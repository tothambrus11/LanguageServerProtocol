import Foundation

/// Client capabilities for the `textDocument/completion` request.
public struct CompletionClientCapabilities: Codable, Hashable, Sendable {
	/// Capabilities the client supports related to completion items.
	public struct CompletionItem: Codable, Hashable, Sendable {
		/// Resolve support capabilities.
		public struct ResolveSupport: Codable, Hashable, Sendable {
			/// The properties that a client can resolve lazily.
			public var properties: [String]

			/// Creates an instance from its parts.
			public init(properties: [String]) {
				self.properties = properties
			}
		}

		/// Whether the client supports snippets as insert text.
		public let snippetSupport: Bool?
		/// Whether the client supports commit characters on a completion item.
		public let commitCharactersSupport: Bool?
		/// The content formats for documentation the client supports.
		public let documentationFormat: [MarkupKind]?
		/// Whether the client supports the deprecated property on a completion item.
		public let deprecatedSupport: Bool?
		/// Whether the client supports the preselect property on a completion item.
		public let preselectSupport: Bool?
		/// The client supports completion item tags.
		///
		/// - Since: 3.15.0
		public var tagSupport: ValueSet<CompletionItemTag>?
		/// Whether the client supports insert/replace edits.
		///
		/// - Since: 3.16.0
		public var insertReplaceSupport: Bool?
		/// Indicates which properties a client can resolve lazily.
		///
		/// - Since: 3.16.0
		public var resolveSupport: ResolveSupport?
		/// The insert text modes the client supports.
		///
		/// - Since: 3.16.0
		public var insertTextModeSupport: ValueSet<InsertTextMode>?
		/// Whether the client supports label details.
		///
		/// - Since: 3.17.0
		public var labelDetailsSupport: Bool?

		/// Creates an instance from its parts.
		public init(
			snippetSupport: Bool? = nil,
			commitCharactersSupport: Bool? = nil,
			documentationFormat: [MarkupKind]? = nil,
			deprecatedSupport: Bool? = nil,
			preselectSupport: Bool? = nil,
			tagSupport: ValueSet<CompletionItemTag>? = nil,
			insertReplaceSupport: Bool? = nil,
			resolveSupport: CompletionItem.ResolveSupport? = nil,
			insertTextModeSupport: ValueSet<InsertTextMode>? = nil,
			labelDetailsSupport: Bool? = nil
		) {
			self.snippetSupport = snippetSupport
			self.commitCharactersSupport = commitCharactersSupport
			self.documentationFormat = documentationFormat
			self.deprecatedSupport = deprecatedSupport
			self.preselectSupport = preselectSupport
			self.tagSupport = tagSupport
			self.insertReplaceSupport = insertReplaceSupport
			self.resolveSupport = resolveSupport
			self.insertTextModeSupport = insertTextModeSupport
			self.labelDetailsSupport = labelDetailsSupport
		}
	}

	/// Capabilities specific to completion lists.
	public struct CompletionList: Codable, Hashable, Sendable {
		/// The client supports item defaults on the completion list.
		public var itemDefaults: [String]?

		/// Creates an instance from its parts.
		public init(itemDefaults: [String]? = nil) {
			self.itemDefaults = itemDefaults
		}
	}

	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Capabilities for completion items.
	public var completionItem: CompletionItem?
	/// The completion item kinds the client supports.
	public var completionItemKind: ValueSet<CompletionItemKind>?
	/// Whether the client supports sending additional context information.
	public var contextSupport: Bool?
	/// The default insert text mode the client prefers.
	///
	/// - Since: 3.17.0
	public var insertTextMode: InsertTextMode?
	/// Capabilities for the completion list.
	///
	/// - Since: 3.17.0
	public var completionList: CompletionList?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool? = nil,
		completionItem: CompletionItem? = nil,
		completionItemKind: ValueSet<CompletionItemKind>? = nil,
		contextSupport: Bool? = nil,
		insertTextMode: InsertTextMode? = nil,
		completionList: CompletionClientCapabilities.CompletionList? = nil
	) {
		self.dynamicRegistration = dynamicRegistration
		self.completionItem = completionItem
		self.completionItemKind = completionItemKind
		self.contextSupport = contextSupport
		self.insertTextMode = insertTextMode
		self.completionList = completionList
	}
}

/// How a completion was triggered.
public enum CompletionTriggerKind: Int, Codable, Hashable, Sendable {
	/// Completion was triggered by typing an identifier or via API.
	case invoked = 1
	/// Completion was triggered by a trigger character.
	case triggerCharacter = 2
	/// Completion was re-triggered as the current completion list is incomplete.
	case triggerForIncompleteCompletions = 3
}

/// The kind of a completion entry.
public enum CompletionItemKind: Int, CaseIterable, Codable, Hashable, Sendable {
	case text = 1
	case method = 2
	case function = 3
	case constructor = 4
	case field = 5
	case variable = 6
	case `class` = 7
	case interface = 8
	case module = 9
	case property = 10
	case unit = 11
	case value = 12
	case `enum` = 13
	case keyword = 14
	case snippet = 15
	case color = 16
	case file = 17
	case reference = 18
	case folder = 19
	case enumMember = 20
	case constant = 21
	case `struct` = 22
	case event = 23
	case `operator` = 24
	case typeParameter = 25
}

/// Completion item tags.
///
/// - Since: 3.15.0
public enum CompletionItemTag: Int, CaseIterable, Codable, Hashable, Sendable {
	/// The completion item is deprecated.
	case deprecated = 1
}

/// Contains additional information about the context in which a completion request is triggered.
public struct CompletionContext: Codable, Hashable, Sendable {
	/// How the completion was triggered.
	public let triggerKind: CompletionTriggerKind
	/// The trigger character that triggered code complete, if `triggerKind` is `triggerCharacter`.
	public let triggerCharacter: String?

	/// Creates an instance from its parts.
	public init(triggerKind: CompletionTriggerKind, triggerCharacter: String?) {
		self.triggerKind = triggerKind
		self.triggerCharacter = triggerCharacter
	}
}

/// Parameters for the `textDocument/completion` request.
public struct CompletionParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position
	/// The completion context.
	public let context: CompletionContext?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, position: Position, context: CompletionContext?
	) {
		self.textDocument = textDocument
		self.position = position
		self.context = context
	}

	/// Creates an instance from a URI, position, and trigger information.
	public init(
		uri: DocumentUri, position: Position, triggerKind: CompletionTriggerKind,
		triggerCharacter: String?
	) {
		let td = TextDocumentIdentifier(uri: uri)
		let ctx = CompletionContext(triggerKind: triggerKind, triggerCharacter: triggerCharacter)

		self.init(textDocument: td, position: position, context: ctx)
	}
}

/// Defines whether the insert text in a completion item should be interpreted as plain text or a snippet.
public enum InsertTextFormat: Int, Codable, Hashable, Sendable {
	/// The primary text to be inserted is treated as a plain string.
	case plaintext = 1
	/// The primary text to be inserted is treated as a snippet.
	case snippet = 2
}

/// A completion item represents a text snippet that is proposed to complete text that is being typed.
public struct CompletionItem: Codable, Hashable, Sendable {
	/// The label of this completion item.
	public let label: String
	/// The kind of this completion item.
	public let kind: CompletionItemKind?
	/// A human-readable string with additional information about this item.
	public let detail: String?
	/// A human-readable string that represents a doc-comment.
	public let documentation: TwoTypeOption<String, MarkupContent>?
	/// Whether this item is deprecated.
	public let deprecated: Bool?
	/// Select this item when showing.
	public let preselect: Bool?
	/// A string that should be used when comparing this item with other items.
	public let sortText: String?
	/// A string that should be used when filtering a set of completion items.
	public let filterText: String?
	/// A string that should be inserted into a document when selecting this completion.
	public let insertText: String?
	/// The format of the insert text.
	public let insertTextFormat: InsertTextFormat?
	/// An edit which is applied to a document when selecting this completion.
	public let textEdit: TwoTypeOption<TextEdit, InsertReplaceEdit>?
	/// Additional text edits applied when selecting this completion.
	public let additionalTextEdits: [TextEdit]?
	/// Characters that commit this completion when typed.
	public let commitCharacters: [String]?
	/// An optional command that is executed after inserting this completion.
	public let command: Command?
	/// A data entry field preserved on a completion item between request rounds.
	public let data: LSPAny?

	/// Creates an instance from its parts.
	public init(
		label: String,
		kind: CompletionItemKind? = nil,
		detail: String? = nil,
		documentation: TwoTypeOption<String, MarkupContent>? = nil,
		deprecated: Bool? = nil,
		preselect: Bool? = nil,
		sortText: String? = nil,
		filterText: String? = nil,
		insertText: String? = nil,
		insertTextFormat: InsertTextFormat? = nil,
		textEdit: TwoTypeOption<TextEdit, InsertReplaceEdit>? = nil,
		additionalTextEdits: [TextEdit]? = nil,
		commitCharacters: [String]? = nil,
		command: Command? = nil,
		data: LSPAny? = nil
	) {
		self.label = label
		self.kind = kind
		self.detail = detail
		self.documentation = documentation
		self.deprecated = deprecated
		self.preselect = preselect
		self.sortText = sortText
		self.filterText = filterText
		self.insertText = insertText
		self.insertTextFormat = insertTextFormat
		self.textEdit = textEdit
		self.additionalTextEdits = additionalTextEdits
		self.commitCharacters = commitCharacters
		self.command = command
		self.data = data
	}
}

/// Represents a collection of completion items to be presented in the editor.
public struct CompletionList: Codable, Hashable, Sendable {
	/// This list is not complete. Further typing should result in recomputing this list.
	public let isIncomplete: Bool
	/// The completion items.
	public let items: [CompletionItem]

	/// Creates an instance from its parts.
	public init(isIncomplete: Bool, items: [CompletionItem]) {
		self.isIncomplete = isIncomplete
		self.items = items
	}
}

/// The response type for `textDocument/completion`.
public typealias CompletionResponse = TwoTypeOption<[CompletionItem], CompletionList>?

extension TwoTypeOption where T == [CompletionItem], U == CompletionList {
	/// The completion items regardless of the response variant.
	public var items: [CompletionItem] {
		switch self {
		case .optionA(let v):
			return v
		case .optionB(let list):
			return list.items
		}
	}

	/// Whether the completion list is incomplete.
	public var isIncomplete: Bool {
		switch self {
		case .optionA:
			return false
		case .optionB(let value):
			return value.isIncomplete
		}
	}
}

/// Registration options for completion.
public struct CompletionRegistrationOptions: Codable {
	/// A document selector to identify the scope of the registration, if any.
	public let documentSelector: DocumentSelector?
	/// The characters that trigger completion automatically, if any.
	public let triggerCharacters: [String]?
	/// Whether the server supports resolving additional completion item properties.
	public let resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector? = nil,
		triggerCharacters: [String]? = nil,
		resolveProvider: Bool? = nil
	) {
		self.documentSelector = documentSelector
		self.triggerCharacters = triggerCharacters
		self.resolveProvider = resolveProvider
	}
}

/// How whitespace and indentation is handled during completion item insertion.
///
/// - Since: 3.16.0
public enum InsertTextMode: Int, CaseIterable, Codable, Hashable, Sendable {
	/// The insertion or replace strings are taken as-is.
	case asIs = 1
	/// The editor adjusts leading whitespace of new lines.
	case adjustIndentation = 2
}
