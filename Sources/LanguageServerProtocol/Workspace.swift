import Foundation

/// The kind of events to watch for file system changes.
public struct WatchKind: OptionSet, Codable, Hashable, Sendable {
	/// The raw option set value.
	public let rawValue: Int

	/// Creates a watch kind from a raw value.
	public init(rawValue: Int) {
		self.rawValue = rawValue
	}

	/// Interested in create events.
	public static let create = WatchKind(rawValue: 1)
	/// Interested in change events.
	public static let change = WatchKind(rawValue: 2)
	/// Interested in delete events.
	public static let delete = WatchKind(rawValue: 4)

	/// Interested in all event types.
	public static let all: WatchKind = [.create, .change, .delete]
}

/// A file system watcher that is registered for file change events.
public struct FileSystemWatcher: Codable, Hashable, Sendable {
	/// The glob pattern to watch.
	public var globPattern: String
	/// The kind of events to watch for, if specified.
	public var kind: WatchKind?

	/// Creates an instance from its parts.
	public init(globPattern: String, kind: WatchKind? = nil) {
		self.globPattern = globPattern
		self.kind = kind
	}
}

/// Registration options for `workspace/didChangeWatchedFiles`.
public struct DidChangeWatchedFilesRegistrationOptions: Codable, Hashable, Sendable {
	/// The watchers to register.
	public var watchers: [FileSystemWatcher]

	/// Creates an instance from its parts.
	public init(watchers: [FileSystemWatcher]) {
		self.watchers = watchers
	}
}

/// The file event type.
public enum FileChangeType: Int, Codable, Hashable, Sendable {
	/// The file got created.
	case created = 1
	/// The file got changed.
	case changed = 2
	/// The file got deleted.
	case deleted = 3
}

/// An event describing a file change.
public struct FileEvent: Codable, Hashable, Sendable {
	/// The file's URI.
	public var uri: DocumentUri
	/// The change type.
	public var type: FileChangeType

	/// Creates an instance from its parts.
	public init(uri: DocumentUri, type: FileChangeType) {
		self.uri = uri
		self.type = type
	}
}

/// Parameters for the `workspace/didChangeWatchedFiles` notification.
public struct DidChangeWatchedFilesParams: Codable, Hashable, Sendable {
	/// The actual file events.
	public var changes: [FileEvent]

	/// Creates an instance from its parts.
	public init(changes: [FileEvent]) {
		self.changes = changes
	}
}

/// A workspace folder.
public struct WorkspaceFolder: Codable, Hashable, Sendable {
	/// The associated URI for this workspace folder.
	public let uri: String
	/// The name of the workspace folder.
	public let name: String

	/// Creates an instance from its parts.
	public init(uri: String, name: String) {
		self.uri = uri
		self.name = name
	}
}

/// The workspace folder change event.
public struct WorkspaceFoldersChangeEvent: Codable, Hashable, Sendable {
	/// The array of added workspace folders.
	public var added: [WorkspaceFolder]
	/// The array of removed workspace folders.
	public var removed: [WorkspaceFolder]

	/// Creates an instance from its parts.
	public init(added: [WorkspaceFolder], removed: [WorkspaceFolder]) {
		self.added = added
		self.removed = removed
	}
}

/// Parameters for the `workspace/didChangeWorkspaceFolders` notification.
public struct DidChangeWorkspaceFoldersParams: Codable, Hashable, Sendable {
	/// The actual workspace folder change event.
	public var event: WorkspaceFoldersChangeEvent

	/// Creates an instance from its parts.
	public init(event: WorkspaceFoldersChangeEvent) {
		self.event = event
	}
}

/// Parameters for the `workspace/didChangeConfiguration` notification.
public struct DidChangeConfigurationParams: Codable, Hashable, Sendable {
	/// The actual changed settings.
	public var settings: LSPAny?

	/// Creates an instance from its parts.
	public init(settings: LSPAny) {
		self.settings = settings
	}
}

/// Tags for symbols.
///
/// - Since: 3.16.0
public enum SymbolTag: Int, Codable, Hashable, CaseIterable, Sendable {
	/// The symbol is deprecated.
	case Deprecated = 1
}

/// Represents information about programming constructs like variables or functions.
public struct SymbolInformation: Codable, Hashable, Sendable {
	/// The name of this symbol.
	public let name: String
	/// The kind of this symbol.
	public let kind: SymbolKind
	/// Tags for this symbol.
	///
	/// - Since: 3.16.0
	public let tags: [SymbolTag]?
	/// Whether the symbol is deprecated.
	public let deprecated: Bool?
	/// The location of this symbol.
	public let location: Location
	/// The name of the symbol containing this symbol, if any.
	public let containerName: String?

	/// Creates an instance from its parts.
	public init(
		name: String, kind: SymbolKind, tags: [SymbolTag]? = nil, deprecated: Bool? = nil,
		location: Location, containerName: String? = nil
	) {
		self.name = name
		self.kind = kind
		self.tags = tags
		self.deprecated = deprecated
		self.location = location
		self.containerName = containerName
	}
}

/// Options to create a file.
public struct CreateFileOptions: Codable, Hashable, Sendable {
	/// Overwrite existing file. Takes precedence over `ignoreIfExists`.
	public let overwrite: Bool?
	/// Ignore if the file already exists.
	public let ignoreIfExists: Bool?
}

/// Create file operation.
public struct CreateFile: Codable, Hashable, Sendable {
	/// The resource operation kind (always `"create"`).
	public let kind: String
	/// The resource to create.
	public let uri: DocumentUri
	/// Additional options, if any.
	public let options: CreateFileOptions?

	/// Creates an instance from its parts.
	public init(kind: String, uri: DocumentUri, options: CreateFileOptions?) {
		self.kind = kind
		self.uri = uri
		self.options = options
	}
}

/// Options to rename a file.
public typealias RenameFileOptions = CreateFileOptions

/// Rename file operation.
public struct RenameFile: Codable, Hashable, Sendable {
	/// The resource operation kind (always `"rename"`).
	public let kind: String
	/// The old (existing) location.
	public let oldUri: DocumentUri
	/// The new location.
	public let newUri: DocumentUri
	/// Rename options.
	public let options: RenameFileOptions

	/// Creates an instance from its parts.
	public init(kind: String, oldUri: DocumentUri, newUri: DocumentUri, options: RenameFileOptions)
	{
		self.kind = kind
		self.oldUri = oldUri
		self.newUri = newUri
		self.options = options
	}
}

/// Options to delete a file.
public struct DeleteFileOptions: Codable, Hashable, Sendable {
	/// Delete the content recursively if a folder is denoted.
	public let recursive: Bool?
	/// Ignore the operation if the file doesn't exist.
	public let ignoreIfNotExists: Bool?

	/// Creates an instance from its parts.
	public init(recursive: Bool?, ignoreIfNotExists: Bool?) {
		self.recursive = recursive
		self.ignoreIfNotExists = ignoreIfNotExists
	}
}

/// Delete file operation.
public struct DeleteFile: Codable, Hashable, Sendable {
	/// The resource operation kind (always `"delete"`).
	public let kind: String
	/// The file to delete.
	public let uri: DocumentUri
	/// Delete options.
	public let options: DeleteFileOptions

	/// Creates an instance from its parts.
	public init(kind: String, uri: DocumentUri, options: DeleteFileOptions) {
		self.kind = kind
		self.uri = uri
		self.options = options
	}
}

/// Describes textual changes on a single text document.
public struct TextDocumentEdit: Codable, Hashable, Sendable {
	/// The text document to change.
	public let textDocument: VersionedTextDocumentIdentifier
	/// The edits to be applied.
	public let edits: [TextEdit]

	/// Creates an instance from its parts.
	public init(textDocument: VersionedTextDocumentIdentifier, edits: [TextEdit]) {
		self.textDocument = textDocument
		self.edits = edits
	}
}

/// A document change in a workspace edit, which is either a text edit or a resource operation.
public enum WorkspaceEditDocumentChange: Codable, Hashable, Sendable {
	/// A text document edit.
	case textDocumentEdit(TextDocumentEdit)
	/// A create file operation.
	case createFile(CreateFile)
	/// A rename file operation.
	case renameFile(RenameFile)
	/// A delete file operation.
	case deleteFile(DeleteFile)

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()

		if let value = try? container.decode(TextDocumentEdit.self) {
			self = .textDocumentEdit(value)
		} else if let value = try? container.decode(CreateFile.self) {
			self = .createFile(value)
		} else if let value = try? container.decode(RenameFile.self) {
			self = .renameFile(value)
		} else {
			let value = try container.decode(DeleteFile.self)
			self = .deleteFile(value)
		}
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()

		switch self {
		case .textDocumentEdit(let value):
			try container.encode(value)
		case .createFile(let value):
			try container.encode(value)
		case .renameFile(let value):
			try container.encode(value)
		case .deleteFile(let value):
			try container.encode(value)
		}
	}
}

/// A workspace edit represents changes to many resources managed in the workspace.
public struct WorkspaceEdit: Codable, Hashable, Sendable {
	/// Holds changes to existing resources, keyed by document URI.
	public let changes: [DocumentUri: [TextEdit]]?
	/// An array of `TextDocumentEdit`s or resource operations, depending on client capability.
	public let documentChanges: [WorkspaceEditDocumentChange]?

	/// Creates an instance from its parts.
	public init(
		changes: [DocumentUri: [TextEdit]]?, documentChanges: [WorkspaceEditDocumentChange]?
	) {
		self.changes = changes
		self.documentChanges = documentChanges
	}
}
