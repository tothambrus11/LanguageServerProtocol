import Foundation
import JSONRPC

/// The LSP any type.
public typealias LSPAny = JSONValue

/// A non-document URI, transferred as a string.
public typealias URI = String

/// A document URI, transferred as a string whose contents can be parsed as a valid URI.
public typealias DocumentUri = String

/// A token used to report progress, provided by the client or server.
public typealias ProgressToken = TwoTypeOption<Int, String>

/// Parameters for the `$/cancelRequest` notification.
public struct CancelParams: Hashable, Codable, Sendable {
	/// The request id to cancel.
	public var id: TwoTypeOption<Int, String>

	/// Creates an instance with a numeric request id.
	public init(id: Int) {
		self.id = .optionA(id)
	}

	/// Creates an instance with a string request id.
	public init(id: String) {
		self.id = .optionB(id)
	}
}

/// Parameters for the `$/progress` notification.
public struct ProgressParams: Hashable, Codable, Sendable {
	/// The progress token provided by the client or server.
	public var token: ProgressToken
	/// The progress data.
	public var value: LSPAny?

	/// Creates an instance from its parts.
	public init(token: ProgressToken, value: LSPAny? = nil) {
		self.token = token
		self.value = value
	}
}

/// Parameters for the `$/logTrace` notification.
public struct LogTraceParams: Hashable, Codable, Sendable {
	/// The message to log.
	public var string: String
	/// Additional verbose information, if any.
	public var verbose: String?

	/// Creates an instance from its parts.
	public init(string: String, verbose: String? = nil) {
		self.string = string
		self.verbose = verbose
	}
}

/// The level of verbosity for trace output.
public enum TraceValue: String, Hashable, Codable, Sendable {
	/// Tracing is disabled.
	case off
	/// Only messages are traced.
	case messages
	/// Messages and verbose output are traced.
	case verbose
}

/// Parameters for the `$/setTrace` notification.
public struct SetTraceParams: Hashable, Codable, Sendable {
	/// The new trace value.
	public var value: TraceValue

	/// Creates an instance from its parts.
	public init(value: TraceValue) {
		self.value = value
	}
}

/// A container for an array of capability values advertised during initialization.
public struct ValueSet<T: Hashable & Codable>: Hashable, Codable {
	/// The supported values.
	public var valueSet: [T]

	/// Creates an instance from an array of values.
	public init(valueSet: [T]) {
		self.valueSet = valueSet
	}

	/// Creates an instance containing a single value.
	public init(value: T) {
		self.valueSet = [value]
	}
}

extension ValueSet: ExpressibleByArrayLiteral {
	public typealias ArrayLiteralElement = T

	public init(arrayLiteral elements: T...) {
		self.valueSet = elements
	}
}

extension ValueSet where T: CaseIterable {
	/// A value set containing all cases.
	public static var all: ValueSet<T> {
		return ValueSet(valueSet: Array(T.allCases))
	}
}

extension ValueSet: Sendable where T: Sendable {
}

/// A well-known language identifier as defined by the LSP specification.
public enum LanguageIdentifier: String, Codable, CaseIterable, Sendable {
	case abap
	case windowsbat = "bat"
	case bibtex
	case clojure = "clojure"
	case coffeescript
	case c
	case cpp
	case csharp
	case css
	case diff
	case dart
	case dockerfile
	case elixir
	case erlang
	case fsharp
	case gitcommit
	case gitrebase
	case go
	case groovy
	case handlebars
	case html
	case ini
	case java
	case javascript
	case javascriptreact
	case json
	case latex
	case less
	case lua
	case makefile
	case markdown
	case objc = "objective-c"
	case objcpp = "objective-cpp"
	case perl
	case perl6
	case php
	case powershell
	case pug = "jade"
	case python
	case r
	case razor
	case ruby
	case rust
	case scss
	case sass
	case scala
	case shaderlab
	case shellscript
	case sql
	case swift
	case typescript
	case typescriptreact
	case tex
	case vb
	case xml
	case xsl
	case yaml
}

/// A document filter denotes a document through properties like language, scheme, or pattern.
public struct DocumentFilter: Codable, Hashable, Sendable {
	/// A language id, like `typescript`.
	public let language: LanguageIdentifier?
	/// A URI scheme, like `file` or `untitled`.
	public let scheme: String?
	/// A glob pattern, like `*.{ts,js}`.
	public let pattern: String?

	/// Creates an instance from its parts.
	public init(language: LanguageIdentifier? = nil, scheme: String? = nil, pattern: String? = nil)
	{
		self.language = language
		self.scheme = scheme
		self.pattern = pattern
	}
}

/// The combination of one or more document filters.
public typealias DocumentSelector = [DocumentFilter]

/// An identifier for a text document using its URI.
public struct TextDocumentIdentifier: Codable, Hashable, Sendable {
	/// The text document's URI.
	public var uri: DocumentUri

	/// Creates an instance from a document URI.
	public init(uri: DocumentUri) {
		self.uri = uri
	}

	/// Creates an instance from a file path, converting it to a `file://` URI.
	public init(path: String) {
		self.uri = URL(fileURLWithPath: path).absoluteString
	}
}

extension TextDocumentIdentifier: CustomStringConvertible {
	public var description: String {
		return uri.description
	}
}
