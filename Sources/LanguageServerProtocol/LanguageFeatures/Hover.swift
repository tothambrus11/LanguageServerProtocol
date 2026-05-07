import Foundation

/// Client capabilities for the `textDocument/hover` request.
public struct HoverClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// The content formats the client supports for hover results.
	public var contentFormat: [MarkupKind]?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool?, contentFormat: [MarkupKind]?) {
		self.dynamicRegistration = dynamicRegistration
		self.contentFormat = contentFormat
	}
}

/// The result of a hover request.
public struct Hover: Codable, Hashable, Sendable {
	/// The hover's content.
	public let contents: ThreeTypeOption<MarkedString, [MarkedString], MarkupContent>
	/// An optional range that applies to the hover.
	public let range: LSPRange?

	/// Creates an instance from its parts.
	public init(
		contents: ThreeTypeOption<MarkedString, [MarkedString], MarkupContent>, range: LSPRange?
	) {
		self.contents = contents
		self.range = range
	}

	/// Creates an instance from a plain string.
	public init(contents: String, range: LSPRange? = nil) {
		self.contents = .optionA(.optionA(contents))
		self.range = range
	}
}

/// The response type for `textDocument/hover`.
public typealias HoverResponse = Hover?
