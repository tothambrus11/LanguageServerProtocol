import Foundation

/// Whether a file operation pattern matches a file or folder.
///
/// - Since: 3.16.0
public enum FileOperationPatternKind: String, Codable, Hashable, Sendable {
	/// The pattern matches a file only.
	case file = "file"
	/// The pattern matches a folder only.
	case folder = "folder"
}

/// Matching options for a file operation pattern.
///
/// - Since: 3.16.0
public struct FileOperationPatternOptions: Codable, Hashable, Sendable {
	/// Whether the pattern should be matched ignoring case.
	public var ignoreCase: Bool?

	/// Creates an instance from its parts.
	public init(ignoreCase: Bool? = nil) {
		self.ignoreCase = ignoreCase
	}
}

/// A pattern to describe in which file operation requests or notifications the server is interested in.
///
/// - Since: 3.16.0
public struct FileOperationPattern: Codable, Hashable, Sendable {
	/// The glob pattern to match.
	public let glob: String
	/// Whether to match files or folders with this pattern.
	public let matches: FileOperationPatternKind?
	/// Additional options for the pattern.
	public let options: FileOperationPatternOptions?

	/// Creates an instance from its parts.
	public init(
		glob: String, matches: FileOperationPatternKind?, options: FileOperationPatternOptions?
	) {
		self.glob = glob
		self.matches = matches
		self.options = options
	}
}

/// A filter to describe in which file operation requests or notifications the server is interested in.
///
/// - Since: 3.16.0
public struct FileOperationFilter: Codable, Hashable, Sendable {
	/// A URI scheme like `file` or `untitled`.
	public var scheme: String?
	/// The actual file operation pattern.
	public var pattern: FileOperationPattern

	/// Creates an instance from its parts.
	public init(scheme: String? = nil, pattern: FileOperationPattern) {
		self.scheme = scheme
		self.pattern = pattern
	}
}

/// Registration options for file operations.
///
/// - Since: 3.16.0
public struct FileOperationRegistrationOptions: Codable, Hashable, Sendable {
	/// The actual filters.
	public var filters: [FileOperationFilter]

	/// Creates an instance from its parts.
	public init(filters: [FileOperationFilter]) {
		self.filters = filters
	}
}

/// Parameters for the `workspace/willCreateFiles` request.
///
/// - Since: 3.16.0
public struct CreateFilesParams: Codable, Hashable, Sendable {
	/// The files that are being created.
	public var files: [FileCreate]

	/// Creates an instance from its parts.
	public init(files: [FileCreate]) {
		self.files = files
	}
}

/// Represents information on a file/folder create.
///
/// - Since: 3.16.0
public struct FileCreate: Codable, Hashable, Sendable {
	/// A `file://` URI for the location of the created file/folder.
	public var uri: String

	/// Creates an instance from its parts.
	public init(uri: String) {
		self.uri = uri
	}
}

/// The response type for `workspace/willCreateFiles`.
public typealias WorkspaceWillCreateFilesResponse = WorkspaceEdit?
