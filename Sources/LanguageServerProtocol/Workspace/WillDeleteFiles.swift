import Foundation

/// Parameters for the `workspace/willDeleteFiles` request.
///
/// - Since: 3.16.0
public struct DeleteFilesParams: Codable, Hashable, Sendable {
	/// The files that are being deleted.
	public var files: [FileDelete]

	/// Creates an instance from its parts.
	public init(files: [FileDelete]) {
		self.files = files
	}
}

/// Represents information on a file/folder delete.
///
/// - Since: 3.16.0
public struct FileDelete: Codable, Hashable, Sendable {
	/// A `file://` URI for the location of the deleted file/folder.
	public var uri: String

	/// Creates an instance from its parts.
	public init(uri: String) {
		self.uri = uri
	}
}

/// The response type for `workspace/willDeleteFiles`.
public typealias WorkspaceWillDeleteFilesResponse = WorkspaceEdit?
