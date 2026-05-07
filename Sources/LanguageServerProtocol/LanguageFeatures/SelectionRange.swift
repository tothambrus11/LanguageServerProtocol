import Foundation

/// Client capabilities for the `textDocument/selectionRange` request.
///
/// - Since: 3.15.0
public typealias SelectionRangeClientCapabilities = DynamicRegistrationClientCapabilities

/// Server capabilities for the selection range feature.
///
/// - Since: 3.15.0
public typealias SelectionRangeOptions = WorkDoneProgressOptions

/// Registration options for selection range.
///
/// - Since: 3.15.0
public typealias SelectionRangeRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Parameters for the `textDocument/selectionRange` request.
///
/// - Since: 3.15.0
public struct SelectionRangeParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The positions inside the text document.
	public let positions: [Position]

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil,
		textDocument: TextDocumentIdentifier, positions: [Position]
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
		self.positions = positions
	}
}

/// A selection range represents a part of a selection hierarchy.
///
/// - Since: 3.15.0
public final class SelectionRange: Codable, Sendable {
	/// The range of this selection range.
	public let range: LSPRange
	/// The parent selection range containing this range.
	public let parent: SelectionRange?

	/// Creates an instance from its parts.
	public init(range: LSPRange, parent: SelectionRange?) {
		self.range = range
		self.parent = parent
	}
}

extension SelectionRange: Equatable {
	public static func == (lhs: SelectionRange, rhs: SelectionRange) -> Bool {
		return lhs.range == rhs.range && lhs.parent == rhs.parent
	}
}

/// The response type for `textDocument/selectionRange`.
public typealias SelectionRangeResponse = [SelectionRange]?
