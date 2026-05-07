import Foundation

/// Client capabilities for the document color feature.
public typealias DocumentColorClientCapabilities = DynamicRegistrationClientCapabilities

/// Parameters for the `textDocument/documentColor` request.
public struct DocumentColorParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public let workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public let partialResultToken: ProgressToken?
	/// The text document.
	public let textDocument: TextDocumentIdentifier

	/// Creates an instance from its parts.
	public init(
		textDocument: TextDocumentIdentifier, workDoneToken: ProgressToken? = nil,
		partialResultToken: ProgressToken? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
		self.textDocument = textDocument
	}
}

/// Represents a color in RGBA space.
public struct Color: Codable, Hashable, Sendable {
	/// The red component in the range [0, 1].
	public let red: Float
	/// The green component in the range [0, 1].
	public let green: Float
	/// The blue component in the range [0, 1].
	public let blue: Float
	/// The alpha component in the range [0, 1].
	public let alpha: Float

	/// Creates an instance from its parts.
	public init(red: Float, green: Float, blue: Float, alpha: Float) {
		self.red = red
		self.green = green
		self.blue = blue
		self.alpha = alpha
	}
}

/// Represents a color range from a document.
public struct ColorInformation: Codable, Hashable, Sendable {
	/// The range in the document where this color appears.
	public let range: LSPRange
	/// The actual color value for this color range.
	public let color: Color

	/// Creates an instance from its parts.
	public init(range: LSPRange, color: Color) {
		self.range = range
		self.color = color
	}
}

/// The response type for `textDocument/documentColor`.
public typealias DocumentColorResponse = [ColorInformation]
