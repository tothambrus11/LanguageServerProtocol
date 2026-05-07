import Foundation

/// Represents an LSP snippet string and provides parsing utilities.
public struct Snippet {
	/// A parsed element of a snippet.
	public enum Element: Equatable {
		/// A plain text element.
		case text(String)
		/// A tabstop with the given index.
		case tabstop(Int)
		/// A placeholder with an index and default text.
		case placeholder(Int, String)
		/// A choice with an index and list of values.
		case choice(Int, [String])
		/// A variable with a name and default value.
		case variable(String, String)
		/// A variable with a transform (name, regex, format, options).
		case variableTransform(String, String, String, String)
	}

	/// The raw snippet string value.
	public let value: String

	/// Creates a snippet from a raw string value.
	public init(value: String) {
		self.value = value
	}
}

extension Snippet {
	/// The ranges of snippet elements within the raw value.
	public var elementRanges: [NSRange] {
		let regex = try! NSRegularExpression(pattern: #"\$(\w+|\{([^$]+)\})"#)

		return regex.matches(inFullString: value).map({ $0.range })
	}

	public func enumerateElements(block: (Element) -> Void) {
		let ranges = elementRanges

		var location = 0

		for range in ranges {
			let textRange = NSMakeRange(location, range.location - location)

			if let v = subvalue(for: textRange) {
				block(textElement(for: v))
			}

			if let content = subvalue(for: range) {
				if let elem = element(for: content) {
					block(elem)
				}
			}

			location = NSMaxRange(range)
		}

		let lastTextRange = NSMakeRange(location, value.utf16.count - location)

		if let v = subvalue(for: lastTextRange) {
			block(textElement(for: v))
		}
	}

	/// All parsed snippet elements.
	public var elements: [Snippet.Element] {
		var list = [Snippet.Element]()

		enumerateElements { (element) in
			list.append(element)
		}

		return list
	}

	private func subvalue(for range: NSRange) -> String? {
		if range.length == 0 {
			return nil
		}

		guard let stringRange = Range(range, in: value) else {
			return nil
		}

		return String(value[stringRange])
	}
}

extension Snippet {
	private func element(for content: String) -> Element? {
		if let elem = tabstop(for: content) {
			return elem
		}

		if let elem = placeholder(for: content) {
			return elem
		}

		return nil
	}

	private func textElement(for content: String) -> Element {
		let adjustedValue = content.replacingOccurrences(of: "\\", with: "")

		return Element.text(adjustedValue)
	}

	private func tabstop(for content: String) -> Element? {
		let regex = try! NSRegularExpression(pattern: "\\$(\\d+)")

		let matches = regex.matches(inFullString: content)

		guard matches.count == 1 else {
			return nil
		}

		guard let tabstopValueRange = matches[0].range(at: 1, in: content) else {
			return nil
		}

		guard let tabstopValue = Int(content[tabstopValueRange]) else {
			return nil
		}

		return Element.tabstop(tabstopValue)
	}

	private func placeholder(for content: String) -> Element? {
		let regex = try! NSRegularExpression(pattern: #"\$\{(\d+):(.*)\}"#)

		let matches = regex.matches(inFullString: content)

		guard matches.count == 1 else {
			return nil
		}

		guard let numberRange = matches[0].range(at: 1, in: content) else {
			return nil
		}

		guard let numberValue = Int(content[numberRange]) else {
			return nil
		}

		let innerContentsRange = matches[0].range(at: 2, in: content)

		let innerContentValue = innerContentsRange.flatMap { String(content[$0]) } ?? ""
		let adjustedValue = innerContentValue.replacingOccurrences(of: "\\", with: "")

		return Element.placeholder(numberValue, adjustedValue)
	}
}

extension Snippet {
	public static func parsePlaceholderValue(_ value: String) -> (String, String) {
		guard let regex = try? NSRegularExpression(pattern: "(\\w+)\\b(.+)") else {
			return (value, value)
		}

		let matches = regex.matches(inFullString: value)
		let match = matches.first

		guard let contentRange = match?.range(at: 1, in: value) else {
			return (value, value)
		}

		guard let labelRange = match?.range(at: 2, in: value) else {
			return (value, value)
		}

		let content = String(value[contentRange])
		let label = String(value[labelRange])

		return (label, content)
	}
}
