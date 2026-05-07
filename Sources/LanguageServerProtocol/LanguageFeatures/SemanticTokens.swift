import Foundation

/// Workspace client capabilities specific to semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensWorkspaceClientCapabilities: Codable, Hashable, Sendable {
	/// Whether the client supports a refresh request sent from the server.
	public var refreshSupport: Bool?

	/// Creates an instance from its parts.
	public init(refreshSupport: Bool) {
		self.refreshSupport = refreshSupport
	}
}

/// The token format.
///
/// - Since: 3.16.0
public enum TokenFormat: String, Codable, Hashable, Sendable {
	/// Tokens are encoded relative to each other.
	case relative = "relative"

	/// Relative token format.
	public static let Relative = TokenFormat.relative
}

/// Client capabilities for the `textDocument/semanticTokens` request.
///
/// - Since: 3.16.0
public struct SemanticTokensClientCapabilities: Codable, Hashable, Sendable {
	/// Which requests the client supports.
	public struct Requests: Codable, Hashable, Sendable {
		/// Range request support.
		public struct Range: Codable, Hashable, Sendable {
		}

		/// Full request support.
		public struct Full: Codable, Hashable, Sendable {
			/// Whether the client supports delta updates for full requests.
			public var delta: Bool?

			/// Creates an instance from its parts.
			public init(delta: Bool = true) {
				self.delta = delta
			}
		}

		/// A union representing range request support.
		public typealias RangeOption = TwoTypeOption<Bool, Range>
		/// A union representing full request support.
		public typealias FullOption = TwoTypeOption<Bool, Full>

		/// Whether range requests are supported.
		public var range: RangeOption?
		/// Whether full document requests are supported.
		public var full: FullOption?

		/// Creates an instance from its parts.
		public init(range: Bool = true, delta: Bool = true) {
			self.range = .optionA(range)
			self.full = .optionB(Full(delta: true))
		}
	}

	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Which requests the client supports and might send.
	public var requests: Requests
	/// The token types that the client supports.
	public var tokenTypes: [String]
	/// The token modifiers that the client supports.
	public var tokenModifiers: [String]
	/// The formats the client supports.
	public var formats: [TokenFormat]
	/// Whether the client supports tokens that can overlap each other.
	public var overlappingTokenSupport: Bool?
	/// Whether the client supports tokens that can span multiple lines.
	public var multilineTokenSupport: Bool?
	/// Whether the client supports a server actively cancelling a semantic token request.
	public var serverCancelSupport: Bool?
	/// Whether the client uses semantic tokens to augment syntax tokens.
	public var augmentsSyntaxTokens: Bool?

	/// Creates an instance from its parts.
	public init(
		dynamicRegistration: Bool = false,
		requests: SemanticTokensClientCapabilities.Requests = .init(range: true, delta: true),
		tokenTypes: [String] = SemanticTokenTypes.allStrings,
		tokenModifiers: [String] = SemanticTokenModifiers.allStrings,
		formats: [TokenFormat] = [TokenFormat.relative],
		overlappingTokenSupport: Bool = true,
		multilineTokenSupport: Bool = true,
		serverCancelSupport: Bool = false,
		augmentsSyntaxTokens: Bool = true
	) {
		self.dynamicRegistration = dynamicRegistration
		self.requests = requests
		self.tokenTypes = tokenTypes
		self.tokenModifiers = tokenModifiers
		self.formats = formats
		self.overlappingTokenSupport = overlappingTokenSupport
		self.multilineTokenSupport = multilineTokenSupport
		self.serverCancelSupport = serverCancelSupport
		self.augmentsSyntaxTokens = augmentsSyntaxTokens
	}
}

/// The legend used by the server to encode semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensLegend: Codable, Hashable, Sendable {
	/// The token types the server uses.
	public var tokenTypes: [String]
	/// The token modifiers the server uses.
	public var tokenModifiers: [String]

	/// Creates an instance from its parts.
	public init(tokenTypes: [String], tokenModifiers: [String]) {
		self.tokenTypes = tokenTypes
		self.tokenModifiers = tokenModifiers
	}
}

/// Predefined semantic token types.
///
/// - Since: 3.16.0
public enum SemanticTokenTypes: String, Codable, Hashable, CaseIterable, Sendable {
	case namespace = "namespace"
	case type = "type"
	case `class` = "class"
	case `enum` = "enum"
	case interface = "interface"
	case `struct` = "struct"
	case typeParameter = "typeParameter"
	case parameter = "parameter"
	case variable = "variable"
	case property = "property"
	case enumMember = "enumMember"
	case event = "event"
	case function = "function"
	case method = "method"
	case macro = "macro"
	case keyword = "keyword"
	case modifier = "modifier"
	case comment = "comment"
	case string = "string"
	case number = "number"
	case regexp = "regexp"
	case `operator` = "operator"

	public static var allStrings: [String] {
		return allCases.map({ $0.rawValue })
	}
}

/// Predefined semantic token modifiers.
///
/// - Since: 3.16.0
public enum SemanticTokenModifiers: String, Codable, Hashable, CaseIterable, Sendable {
	case declaration = "declaration"
	case definition = "definition"
	case readonly = "readonly"
	case `static` = "static"
	case deprecated = "deprecated"
	case abstract = "abstract"
	case async = "async"
	case modification = "modification"
	case documentation = "documentation"
	case defaultLibrary = "defaultLibrary"

	public static var allStrings: [String] {
		return allCases.map({ $0.rawValue })
	}
}

/// Parameters for the `textDocument/semanticTokens/full` request.
///
/// - Since: 3.16.0
public struct SemanticTokensParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public var partialResultToken: ProgressToken?
	/// The text document.
	public var textDocument: TextDocumentIdentifier

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier) {
		self.textDocument = textDocument
	}
}

/// A single semantic token with its position and type information.
public struct SemanticToken: Codable, Hashable, Sendable {
	// typealias EncodedTuple = (line: UInt32, char: UInt32, length: UInt32, type: UInt32, modifiers: UInt32)

	/// The zero-based line number.
	public let line: UInt32
	/// The zero-based character offset.
	public let char: UInt32
	/// The length of the token.
	public let length: UInt32
	/// The token type index into the legend.
	public let type: UInt32
	/// Bit flags for token modifiers.
	public let modifiers: UInt32

	/// The number of fields per encoded token.
	public static let numFields = 5

	// public func toArray() -> EncodedTuple {
	// }

	/// Creates an instance from its parts.
	public init(line: UInt32, char: UInt32, length: UInt32, type: UInt32, modifiers: UInt32 = 0) {
		self.line = line
		self.char = char
		self.length = length
		self.type = type
		self.modifiers = modifiers
	}
}

/// Semantic tokens result.
///
/// - Since: 3.16.0
public struct SemanticTokens: Codable, Hashable, Sendable {
	/// An optional result id. If provided and clients support delta updating,
	/// the client will include the result id in the next semantic token request.
	/// A server can then send a delta instead of recomputing all semantic tokens.
	public var resultId: String?

	/// Encoded token data
	public var data: [UInt32]

	/// Creates an instance from a result ID and raw encoded data.
	public init(resultId: String? = nil, data: [UInt32]) {
		self.resultId = resultId
		self.data = data
	}

	func getLineTokens(_ tokens: Array<SemanticToken>.SubSequence) -> Line {
		precondition(!tokens.isEmpty)

		var end = tokens.startIndex + 1
		let line = tokens[tokens.startIndex].line

		while end < tokens.endIndex && tokens[end].line == line {
			end += 1
		}

		return Line(line: line, tokens: tokens[tokens.startIndex..<end])
	}

	mutating func encodeLine(_ tokens: Array<SemanticToken>.SubSequence, prevLine: UInt32) {

		// Sort line tokens
		let sortedTokens = tokens.sorted { $0.char < $1.char }

		var prevCol: UInt32 = 0
		var prevLine = prevLine

		for i in 0..<sortedTokens.count {
			let d0 = (tokens.startIndex + i) * SemanticToken.numFields
			let t = sortedTokens[i]

			self.data[d0 + 0] = t.line - prevLine
			self.data[d0 + 1] = t.char - prevCol
			self.data[d0 + 2] = t.length
			self.data[d0 + 3] = t.type
			self.data[d0 + 4] = t.modifiers

			prevLine = t.line
			prevCol = t.char
		}
	}

	struct Line {
		public let line: UInt32
		public let tokens: Array<SemanticToken>.SubSequence
	}

	// Convert tokens to encoded packed array format
	// https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
	public init(resultId: String? = nil, tokens: [SemanticToken]) {
		self.resultId = resultId
		self.data = Array(repeating: 0, count: tokens.count * SemanticToken.numFields)

		var tail = tokens[...]
		var lines: [Line] = []
		while !tail.isEmpty {
			let line = getLineTokens(tail)
			lines.append(line)
			tail = tail[line.tokens.endIndex...]
		}

		// Sort lines
		let sortedLines = lines.sorted { $0.line < $1.line }

		var prevLine: UInt32 = 0
		for line in sortedLines {
			encodeLine(line.tokens, prevLine: prevLine)
			prevLine = line.line
		}
	}

	// Convert encoded packed array format to SemanticToken array
	// https://microsoft.github.io/language-server-protocol/specifications/lsp/3.17/specification/#textDocument_semanticTokens
	public func decode() -> [SemanticToken] {
		var tokens: [SemanticToken] = []

		var currentRow: UInt32 = 0
		var currentCol: UInt32 = 0
		let numTokens = data.count / 5
		tokens.reserveCapacity(numTokens)

		for n in 0..<numTokens {
			let i = n * 5

			// Check if new line
			if data[i] > 0 {
				currentCol = 0
			}

			let token = SemanticToken(
				line: data[i] + currentRow,
				char: data[i + 1] + currentCol,
				length: data[i + 2],
				type: data[i + 3],
				modifiers: data[i + 4]
			)

			tokens.append(token)
			currentRow += data[i]
			currentCol += data[i + 1]
		}

		return tokens
	}
}

/// The response type for `textDocument/semanticTokens/full`.
public typealias SemanticTokensResponse = SemanticTokens?

/// A partial result for semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensPartialResult: Codable, Hashable, Sendable {
	/// The encoded token data.
	public var data: [UInt32]
}

/// Parameters for the `textDocument/semanticTokens/full/delta` request.
///
/// - Since: 3.16.0
public struct SemanticTokensDeltaParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public var partialResultToken: ProgressToken?
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The result ID of a previous response to compute the delta from.
	public var previousResultId: String

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, previousResultId: String) {
		self.textDocument = textDocument
		self.previousResultId = previousResultId
	}
}

/// Describes an edit to semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensEdit: Codable, Hashable, Sendable {
	/// The start offset of the edit.
	public var start: UInt
	/// The number of elements to remove.
	public var deleteCount: UInt
	/// The elements to insert.
	public var data: [UInt32]?
}

/// A delta result for semantic tokens.
///
/// - Since: 3.16.0
public struct SemanticTokensDelta: Codable, Hashable, Sendable {
	/// An optional result ID for further delta requests.
	public var resultId: String?
	/// The semantic token edits.
	public var edits: [SemanticTokensEdit]
}

/// The response type for `textDocument/semanticTokens/full/delta`.
public typealias SemanticTokensDeltaResponse = TwoTypeOption<SemanticTokens, SemanticTokensDelta>?

/// Parameters for the `textDocument/semanticTokens/range` request.
///
/// - Since: 3.16.0
public struct SemanticTokensRangeParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public var partialResultToken: ProgressToken?
	/// The text document.
	public var textDocument: TextDocumentIdentifier
	/// The range the semantic tokens are requested for.
	public var range: LSPRange

	/// Creates an instance from its parts.
	public init(textDocument: TextDocumentIdentifier, range: LSPRange) {
		self.textDocument = textDocument
		self.range = range
	}
}

extension TwoTypeOption where T == SemanticTokens, U == SemanticTokensDelta {
	/// The result id regardless of the response variant, if any.
	public var resultId: String? {
		switch self {
		case .optionA(let token):
			return token.resultId
		case .optionB(let delta):
			return delta.resultId
		}
	}
}
