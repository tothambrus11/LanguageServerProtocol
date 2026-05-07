import Foundation

/// Parameters for the `workspace/willRenameFiles` request.
///
/// - Since: 3.16.0
public struct RenameFilesParams: Codable, Hashable, Sendable {
	/// The files that are being renamed.
	public var files: [FileRename]

	/// Creates an instance from its parts.
	public init(files: [FileRename]) {
		self.files = files
	}
}

/// Represents information on a file/folder rename.
///
/// - Since: 3.16.0
public struct FileRename: Codable, Hashable, Sendable {
	/// A `file://` URI for the original location of the file/folder.
	public var oldUri: String
	/// A `file://` URI for the new location of the file/folder.
	public var newUri: String

	/// Creates an instance from its parts.
	public init(oldUri: String, newUri: String) {
		self.oldUri = oldUri
		self.newUri = newUri
	}
}

/// The response type for `workspace/willRenameFiles`.
public typealias WorkspaceWillRenameFilesResponse = WorkspaceEdit?
