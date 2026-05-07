import Foundation

/// The default behavior for prepare rename.
///
/// - Since: 3.16.0
public enum PrepareSupportDefaultBehavior: Int, CaseIterable, Codable, Hashable, Sendable {
	/// The client's default behavior is to select the identifier according to the language's syntax rule.
	case Identifier = 1
}

/// Client capabilities for the `textDocument/rename` request.
public struct RenameClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public let dynamicRegistration: Bool?
	/// Whether the client supports testing for validity of rename operations before execution.
	public let prepareSupport: Bool?
	/// The client's default behavior when no result-specific behavior is defined.
	///
	/// - Since: 3.16.0
	public let prepareSupportDefaultBehavior: PrepareSupportDefaultBehavior?
	/// Whether the client honors change annotations.
	///
	/// - Since: 3.16.0
	public let honorsChangeAnnotations: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool?, prepareSupport: Bool?,
		prepareSupportDefaultBehavior: PrepareSupportDefaultBehavior?,
		honorsChangeAnnotations: Bool?
	) {
		self.dynamicRegistration = dynamicRegistration
		self.prepareSupport = prepareSupport
		self.prepareSupportDefaultBehavior = prepareSupportDefaultBehavior
		self.honorsChangeAnnotations = honorsChangeAnnotations
	}
}

/// Server capabilities for the rename feature.
public struct RenameOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// Whether renames should be checked and tested before being executed.
	public var prepareProvider: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, prepareProvider: Bool? = nil) {
		self.workDoneProgress = workDoneProgress
		self.prepareProvider = prepareProvider
	}
}

/// Parameters for the `textDocument/prepareRename` request.
public typealias PrepareRenameParams = TextDocumentPositionParams

/// Parameters for the `textDocument/rename` request.
public struct RenameParams: Codable, Hashable, Sendable {
	/// The document to rename.
	public let textDocument: TextDocumentIdentifier
	/// The position at which this request was sent.
	public let position: Position
	/// The new name of the symbol.
	public let newName: String

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, position: Position, newName: String) {
		self.textDocument = textDocument
		self.position = position
		self.newName = newName
	}
}

/// A range with a placeholder for rename.
public struct RangeWithPlaceholder: Codable, Hashable, Sendable {
	/// The range of the string to rename.
	public let range: LSPRange
	/// A placeholder text of the string content to be renamed.
	public let placeholder: String

	/// Creates an instance from its parts.
	public init(range: LSPRange, placeholder: String) {
		self.range = range
		self.placeholder = placeholder
	}
}

/// Indicates the default behavior for prepare rename.
public struct PrepareRenameDefaultBehavior: Codable, Hashable, Sendable {
	/// Whether the default behavior is to be used.
	public let defaultBehavior: Bool

	/// Creates an instance from its parts.
	public init(defaultBehavior: Bool) {
		self.defaultBehavior = defaultBehavior
	}
}

/// The response type for `textDocument/prepareRename`.
public typealias PrepareRenameResponse = ThreeTypeOption<
	LSPRange, RangeWithPlaceholder, PrepareRenameDefaultBehavior
>?

/// The response type for `textDocument/rename`.
public typealias RenameResponse = WorkspaceEdit?
