import Foundation

/// Client capabilities for the call hierarchy feature.
///
/// - Since: 3.16.0
public typealias CallHierarchyClientCapabilities = DynamicRegistrationClientCapabilities

/// Server capabilities for the call hierarchy feature.
///
/// - Since: 3.16.0
public typealias CallHierarchyOptions = WorkDoneProgressOptions

/// Registration options for call hierarchy.
///
/// - Since: 3.16.0
public typealias CallHierarchyRegistrationOptions =
	StaticRegistrationWorkDoneProgressTextDocumentRegistrationOptions

/// Parameters for the `textDocument/prepareCallHierarchy` request.
///
/// - Since: 3.16.0
public struct CallHierarchyPrepareParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position
	/// An optional work done progress token.
	public let workDoneToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, position: Position,
		workDoneToken: ProgressToken? = nil
	) {
		self.textDocument = textDocument
		self.position = position
		self.workDoneToken = workDoneToken
	}
}

/// Represents programming constructs like functions or constructors in the context of call hierarchy.
///
/// - Since: 3.16.0
public struct CallHierarchyItem: Codable, Hashable, Sendable {
	/// The name of this item.
	public let name: String
	/// The kind of this item.
	public let kind: SymbolKind
	/// Tags for this item.
	public let tag: [SymbolTag]?
	/// More detail for this item, e.g. the signature of a function.
	public let detail: String?
	/// The resource identifier of this item.
	public let uri: DocumentUri
	/// The range enclosing this symbol.
	public let range: LSPRange
	/// The range that should be selected and revealed when this symbol is being picked.
	public let selectionRange: LSPRange
	/// A data entry field that is preserved between request rounds.
	public let data: LSPAny?

	/// Creates an instance from its parts.
	public init(
		name: String,
		kind: SymbolKind,
		tag: [SymbolTag]? = nil,
		detail: String? = nil,
		uri: DocumentUri,
		range: LSPRange,
		selectionRange: LSPRange,
		data: LSPAny? = nil
	) {
		self.name = name
		self.kind = kind
		self.tag = tag
		self.detail = detail
		self.uri = uri
		self.range = range
		self.selectionRange = selectionRange
		self.data = data
	}
}

/// The response type for `textDocument/prepareCallHierarchy`.
public typealias CallHierarchyPrepareResponse = [CallHierarchyItem]?

/// Parameters for the `callHierarchy/incomingCalls` request.
///
/// - Since: 3.16.0
public struct CallHierarchyIncomingCallsParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?

	/// The call hierarchy item to resolve incoming calls for.
	public let item: CallHierarchyItem

	/// Creates an instance from its parts.
	public init(
		item: CallHierarchyItem, workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.item = item
	}
}

/// Represents an incoming call, e.g. a caller of a method.
///
/// - Since: 3.16.0
public struct CallHierarchyIncomingCall: Codable, Hashable, Sendable {
	/// The item that makes the call.
	public let from: CallHierarchyItem
	/// The ranges at which the calls appear.
	public let fromRanges: [LSPRange]

	/// Creates an instance from its parts.
	public init(
		from: CallHierarchyItem, fromRanges: [LSPRange]
	) {
		self.from = from
		self.fromRanges = fromRanges
	}
}

/// The response type for `callHierarchy/incomingCalls`.
public typealias CallHierarchyIncomingCallsResponse = [CallHierarchyIncomingCall]?

/// Parameters for the `callHierarchy/outgoingCalls` request.
public typealias CallHierarchyOutgoingCallsParams = CallHierarchyIncomingCallsParams

/// Represents an outgoing call, e.g. calling a method from a given item.
///
/// - Since: 3.16.0
public struct CallHierarchyOutgoingCall: Codable, Hashable, Sendable {
	/// The item that is called.
	public let to: CallHierarchyItem
	/// The range at which this item is called.
	public let fromRanges: [LSPRange]

	/// Creates an instance from its parts.
	public init(to: CallHierarchyItem, fromRanges: [LSPRange]) {
		self.to = to
		self.fromRanges = fromRanges
	}
}

/// The response type for `callHierarchy/outgoingCalls`.
public typealias CallHierarchyOutgoingCallsResponse = [CallHierarchyOutgoingCall]?
