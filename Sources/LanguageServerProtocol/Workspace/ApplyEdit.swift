import Foundation

/// Parameters for the `workspace/applyEdit` request.
public struct ApplyWorkspaceEditParams: Codable, Hashable, Sendable {
	/// An optional label of the workspace edit.
	public var label: String?
	/// The edits to apply.
	public var edit: WorkspaceEdit

	/// Creates an instance from its parts.
	public init(label: String? = nil, edit: WorkspaceEdit) {
		self.label = label
		self.edit = edit
	}
}

/// The result returned from the `workspace/applyEdit` request.
public struct ApplyWorkspaceEditResult: Codable, Hashable, Sendable {
	/// Whether the edit was applied.
	public var applied: Bool
	/// A human-readable reason why the edit was not applied, if applicable.
	public var failureReason: String?
	/// The index of the change that failed, depending on the client capability.
	public var failedChange: UInt?

	/// Creates an instance from its parts.
	public init(applied: Bool, failureReason: String? = nil, failedChange: UInt? = nil) {
		self.applied = applied
		self.failureReason = failureReason
		self.failedChange = failedChange
	}
}
