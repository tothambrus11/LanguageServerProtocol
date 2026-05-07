import Foundation

/// A position in a text document expressed as zero-based line and zero-based character offset.
public struct Position: Codable, Hashable, Sendable {
	/// The origin position (line 0, character 0).
	public static let zero = Position(line: 0, character: 0)

	/// Zero-based line position in a document.
	public let line: Int
	/// Zero-based character offset on a line, interpreted according to the negotiated `PositionEncodingKind`.
	public let character: Int

	/// Creates an instance from 0-based line and character offsets.
	/// 
	/// Note: `character` is interpreted according to the negotiated `PositionEncodingKind`.
	public init(line: Int, character: Int) {
		self.line = line
		self.character = character
	}

	/// Creates an instance from a (line, character) tuple.
	public init(_ pair: (Int, Int)) {
		self.line = pair.0
		self.character = pair.1
	}
}

extension Position: CustomStringConvertible {
	public var description: String {
		return "{\(line), \(character)}"
	}
}

extension Position: Comparable {
	public static func < (lhs: Position, rhs: Position) -> Bool {
		if lhs.line == rhs.line {
			return lhs.character < rhs.character
		}

		return lhs.line < rhs.line
	}
}

extension Range where Bound == Position {
	/// Creates a half-open range from explicit start and end positions.
	public init(_ start: Position, _ end: Position) {
		self.init(uncheckedBounds: (lower: start, upper: end))
	}

	/// Creates a half-open range from an `LSPRange`.
	public init(_ range: LSPRange) {
		self.init(uncheckedBounds: (lower: range.start, upper: range.end))
	}
}

/// A range in a text document expressed as zero-based start and end positions.
///
/// The end position is exclusive.
public struct LSPRange: Codable, Hashable, Sendable {
	/// The empty range at the origin position.
	public static let zero = LSPRange(start: .zero, end: .zero)

	/// The range's start position (inclusive).
	public let start: Position
	/// The range's end position (exclusive).
	public let end: Position

	/// Creates an instance from its parts.
	public init(start: Position, end: Position) {
		self.start = start
		self.end = end
	}

	/// Creates an instance from (line, character) tuples.
	public init(startPair: (Int, Int), endPair: (Int, Int)) {
		self.start = Position(startPair)
		self.end = Position(endPair)
	}

	/// Creates an instance from a `Range<Position>`.
	public init(_ other: Range<Position>) {
		self.start = other.lowerBound
		self.end = other.upperBound
	}

	public func contains(_ position: Position) -> Bool {
		return position > start && position < end
	}

	public func intersects(_ other: LSPRange) -> Bool {
		return contains(other.start) || contains(other.end)
	}

	/// Whether start equals end.
	public var isEmpty: Bool {
		return start == end
	}
}

extension LSPRange: CustomStringConvertible {
	public var description: String {
		return "(\(start), \(end))"
	}
}

/// An item to transfer a text document from the client to the server.
public struct TextDocumentItem: Codable, Hashable, Sendable {
	/// The text document's URI.
	public let uri: DocumentUri
	/// The text document's language identifier.
	public let languageId: String
	/// The version number of this document (increases after each change, including undo/redo).
	public let version: Int
	/// The content of the opened text document.
	public let text: String

	/// Creates an instance from its parts.
	public init(uri: DocumentUri, languageId: LanguageIdentifier, version: Int, text: String) {
		self.uri = uri
		self.languageId = languageId.rawValue
		self.version = version
		self.text = text
	}

	/// Creates an instance from its parts using a raw language id string.
	public init(uri: DocumentUri, languageId: String, version: Int, text: String) {
		self.uri = uri
		self.languageId = languageId
		self.version = version
		self.text = text
	}
}

/// An identifier to denote a specific version of a text document.
public struct VersionedTextDocumentIdentifier: Codable, Hashable, Sendable {
	/// The text document's URI.
	public let uri: DocumentUri
	/// The version number of this document, if known.
	public let version: Int?

	/// Creates an instance from its parts.
	public init(uri: DocumentUri, version: Int?) {
		self.uri = uri
		self.version = version
	}
}

extension VersionedTextDocumentIdentifier: CustomStringConvertible {
	public var description: String {
		let vString = version.map { String($0) } ?? "<unknown>"

		return "\(uri.description): Version \(vString)"
	}
}

/// A location inside a resource, such as a line inside a text file.
public struct Location: Codable, Hashable, Sendable {
	/// The document URI.
	public let uri: DocumentUri
	/// The range within the document.
	public let range: LSPRange

	/// Creates an instance from its parts.
	public init(uri: DocumentUri, range: LSPRange) {
		self.uri = uri
		self.range = range
	}
}

/// A reference to a command identified by a string.
public struct Command: Codable, Hashable, Sendable {
	/// A title shown in the UI for this command.
	public let title: String
	/// The identifier of the actual command handler.
	public let command: String
	/// Arguments passed to the command handler, if any.
	public let arguments: [LSPAny]?

	/// Creates an instance from its parts.
	public init(title: String, command: String, arguments: [LSPAny]? = nil) {
		self.title = title
		self.command = command
		self.arguments = arguments
	}
}

/// The kind of a symbol.
public enum SymbolKind: Int, CaseIterable, Hashable, Codable, Sendable {
	case file = 1
	case module = 2
	case namespace = 3
	case package = 4
	case `class` = 5
	case method = 6
	case property = 7
	case field = 8
	case constructor = 9
	case `enum` = 10
	case interface = 11
	case function = 12
	case variable = 13
	case constant = 14
	case string = 15
	case number = 16
	case boolean = 17
	case array = 18
	case object = 19
	case key = 20
	case null = 21
	case enumMember = 22
	case `struct` = 23
	case event = 24
	case `operator` = 25
	case typeParameter = 26
}

/// The format used for markup content.
public enum MarkupKind: String, Codable, Hashable, Sendable {
	/// Plain text.
	case plaintext
	/// Markdown.
	case markdown
}

/// A parameter literal used in requests to pass a text document and a position inside that document.
public struct TextDocumentPositionParams: Codable, Hashable, Sendable {
	/// The text document.
	public let textDocument: TextDocumentIdentifier
	/// The position inside the text document.
	public let position: Position

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, position: Position) {
		self.textDocument = textDocument
		self.position = position
	}

	/// Creates an instance from a document URI and position.
	public init(uri: DocumentUri, position: Position) {
		let textDocId = TextDocumentIdentifier(uri: uri)

		self.init(textDocument: textDocId, position: position)
	}
}

/// A language-tagged string value used in legacy hover results.
public struct LanguageStringPair: Codable, Hashable, Sendable {
	/// The language identifier.
	public let language: LanguageIdentifier
	/// The string value.
	public let value: String

	/// Creates an instance from its parts.
	public init(language: LanguageIdentifier, value: String) {
		self.language = language
		self.value = value
	}
}

/// A marked string either as a plain string or a language-tagged value.
public typealias MarkedString = TwoTypeOption<String, LanguageStringPair>

extension MarkedString {
	/// The string value regardless of variant.
	public var value: String {
		switch self {
		case .optionA(let string):
			return string
		case .optionB(let pair):
			return pair.value
		}
	}
}

/// A `MarkupContent` literal represents a string value with a given format (plaintext or markdown).
public struct MarkupContent: Codable, Hashable, Sendable {
	/// The markup format.
	public let kind: MarkupKind
	/// The content string.
	public let value: String

	/// Creates an instance from its parts.
	public init(kind: MarkupKind, value: String) {
		self.kind = kind
		self.value = value
	}
}

/// A link between a source and a target location.
///
/// - Since: 3.14.0
public struct LocationLink: Codable, Hashable, Sendable {
	/// Creates an instance from its parts.
	public init(
		originSelectionRange: LSPRange? = nil, targetUri: String, targetRange: LSPRange,
		targetSelectionRange: LSPRange
	) {
		self.originSelectionRange = originSelectionRange
		self.targetUri = targetUri
		self.targetRange = targetRange
		self.targetSelectionRange = targetSelectionRange
	}

	/// The span of the origin of this link used as the underlined range for mouse interaction, if any.
	public let originSelectionRange: LSPRange?
	/// The target resource identifier.
	public let targetUri: String
	/// The full target range (used for highlighting).
	public let targetRange: LSPRange
	/// The range that should be selected and revealed when this link is followed.
	public let targetSelectionRange: LSPRange
}
