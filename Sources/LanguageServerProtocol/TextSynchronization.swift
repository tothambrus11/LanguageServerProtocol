import Foundation

/// Parameters for the `textDocument/didOpen` notification.
public struct DidOpenTextDocumentParams: Codable, Hashable, Sendable {
	/// The document that was opened.
	public let textDocument: TextDocumentItem

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentItem) {
		self.textDocument = textDocument
	}
}

/// An event describing a change to a text document.
public struct TextDocumentContentChangeEvent: Codable, Hashable, Sendable {
	/// The range of the document that changed, if incremental. `nil` for full sync.
	public let range: LSPRange?
	/// The length of the range that got replaced (deprecated, use `range` instead).
	public let rangeLength: Int?
	/// The new text for the provided range, or the full document content.
	public let text: String

	/// Creates an instance from its parts.
	public init(range: LSPRange?, rangeLength: Int?, text: String) {
		self.range = range
		self.rangeLength = rangeLength
		self.text = text
	}
}

/// Parameters for the `textDocument/didChange` notification.
public struct DidChangeTextDocumentParams: Codable, Hashable, Sendable {
	/// The document that did change, including the version number.
	public let textDocument: VersionedTextDocumentIdentifier
	/// The actual content changes.
	public let contentChanges: [TextDocumentContentChangeEvent]

	/// Creates an instance from its parts.
	public init(
		textDocument: VersionedTextDocumentIdentifier,
		contentChanges: [TextDocumentContentChangeEvent]
	) {
		self.textDocument = textDocument
		self.contentChanges = contentChanges
	}

	/// Creates an instance from a URI, version, and content changes.
	public init(uri: DocumentUri, version: Int, contentChanges: [TextDocumentContentChangeEvent]) {
		self.textDocument = VersionedTextDocumentIdentifier(uri: uri, version: version)
		self.contentChanges = contentChanges
	}

	/// Creates an instance from a URI, version, and a single content change.
	public init(uri: DocumentUri, version: Int, contentChange: TextDocumentContentChangeEvent) {
		self.textDocument = VersionedTextDocumentIdentifier(uri: uri, version: version)
		self.contentChanges = [contentChange]
	}
}

/// Registration options for text document change notifications.
public struct TextDocumentChangeRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration.
	public let documentSelector: DocumentSelector?
	/// How documents are synced.
	public let syncKind: TextDocumentSyncKind

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector?,
		syncKind: TextDocumentSyncKind
	) {
		self.documentSelector = documentSelector
		self.syncKind = syncKind
	}
}

/// Parameters for the `textDocument/didSave` notification.
public struct DidSaveTextDocumentParams: Codable, Hashable, Sendable {
	/// The document that was saved.
	public let textDocument: TextDocumentIdentifier
	/// The content when saved, if requested via `includeText`.
	public let text: String?

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, text: String? = nil) {
		self.textDocument = textDocument
		self.text = text
	}

	/// Creates an instance from a document URI.
	public init(uri: DocumentUri, text: String? = nil) {
		let docId = TextDocumentIdentifier(uri: uri)

		self.textDocument = docId
		self.text = text
	}
}

/// Registration options for text document save notifications.
public struct TextDocumentSaveRegistrationOptions: Codable, Hashable, Sendable {
	/// A document selector to identify the scope of the registration.
	public let documentSelector: DocumentSelector?
	/// Whether the client is supposed to include the content on save.
	public let includeText: Bool?

	/// Creates an instance from its parts.
	public init(
		documentSelector: DocumentSelector?,
		includeText: Bool? = nil
	) {
		self.documentSelector = documentSelector
		self.includeText = includeText
	}
}

/// Parameters for the `textDocument/didClose` notification.
public struct DidCloseTextDocumentParams: Codable, Hashable, Sendable {
	/// The document that was closed.
	public let textDocument: TextDocumentIdentifier

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier) {
		self.textDocument = textDocument
	}

	/// Creates an instance from a document URI.
	public init(uri: DocumentUri) {
		let docId = TextDocumentIdentifier(uri: uri)

		self.init(textDocument: docId)
	}
}

/// The reason why a text document is saved.
public enum TextDocumentSaveReason: Int, Codable, Hashable, Sendable {
	/// Manually triggered, e.g. by the user pressing save.
	case manual = 1
	/// Automatic after a delay.
	case afterDelay = 2
	/// When the editor lost focus.
	case focusOut = 3
}

/// Parameters for the `textDocument/willSave` notification.
public struct WillSaveTextDocumentParams: Codable, Hashable, Sendable {
	/// The document that will be saved.
	public let textDocument: TextDocumentIdentifier
	/// The reason for the save.
	public let reason: TextDocumentSaveReason

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, reason: TextDocumentSaveReason) {
		self.textDocument = textDocument
		self.reason = reason
	}
}

/// The response type for `textDocument/willSaveWaitUntil`.
public typealias WillSaveWaitUntilResponse = [TextEdit]?

/// A special text edit to provide an insert and a replace operation.
///
/// https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#insertReplaceEdit
///
/// - Since: 3.16.0
public struct InsertReplaceEdit: Codable, Hashable, Sendable {
	/// The string to be inserted.
	public let newText: String
	/// The range if the insert is requested.
	public let insert: LSPRange
	/// The range if the replace is requested.
	public let replace: LSPRange

	/// Creates an instance from its parts.
	public init(newText: String, insert: LSPRange, replace: LSPRange) {
		self.newText = newText
		self.insert = insert
		self.replace = replace
	}
}

/// A textual edit applicable to a text document.
public struct TextEdit: Codable, Hashable, Sendable {
	/// The range of the text document to be manipulated.
	public let range: LSPRange
	/// The string to be inserted. For delete operations use an empty string.
	public let newText: String

	/// Creates an instance from its parts.
	public init(range: LSPRange, newText: String) {
		self.range = range
		self.newText = newText
	}

	/// Whether this edit has no effect (empty range and empty text).
	public var isNoOp: Bool {
		return range.isEmpty && newText.isEmpty
	}

	/// Whether this edit is a pure insertion (empty range with non-empty text).
	public var isInsert: Bool {
		return range.isEmpty && (newText.isEmpty == false)
	}

	/// Adjusts the input array so that it can be applied, in order
	/// to produce the desired final state
	///
	/// This function *requires* the input edits to meet the LSP spec. In
	/// particular:
	/// - overlaps are not allowed
	/// - inserts with the same starting location must be applied in the order
	///   they appear in the array.
	public static func makeApplicable(_ edits: [TextEdit]) -> [TextEdit] {
		var finalEdits = [TextEdit]()

		for edit in edits {
			if edit.isNoOp {
				continue
			}

			guard let last = finalEdits.last else {
				finalEdits.append(edit)
				continue
			}

			guard edit.isInsert && last.isInsert && edit.range == last.range else {
				finalEdits.append(edit)
				continue
			}

			let combinedEdit = TextEdit(
				range: edit.range,
				newText: last.newText + edit.newText)

			finalEdits.removeLast()
			finalEdits.append(combinedEdit)
		}

		return finalEdits.sorted(by: {
			return $1.range.start < $0.range.start
		})
	}
}

extension TextEdit: CustomStringConvertible {
	public var description: String {
		return "\(range): \"\(newText)\""
	}
}
