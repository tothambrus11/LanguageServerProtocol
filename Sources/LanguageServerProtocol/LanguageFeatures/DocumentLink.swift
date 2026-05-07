//
//  File.swift
//
//
//  Created by Matthew Massicotte on 2022-02-18.
//

import Foundation

/// Client capabilities for the document link feature.
public struct DocumentLinkClientCapabilities: Codable, Hashable, Sendable {
	/// Whether dynamic registration is supported.
	public var dynamicRegistration: Bool?
	/// Whether the client supports tooltips on document links.
	///
	/// - Since: 3.15.0
	public var tooltipSupport: Bool?

	/// Creates an instance from its parts.
	public init(dynamicRegistration: Bool, tooltipSupport: Bool? = nil) {
		self.dynamicRegistration = dynamicRegistration
		self.tooltipSupport = tooltipSupport
	}
}

/// Server capabilities for the document link feature.
public struct DocumentLinkOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// Whether the server supports resolving additional document link properties.
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(workDoneProgress: Bool? = nil, resolveProvider: Bool? = nil) {
		self.workDoneProgress = workDoneProgress
		self.resolveProvider = resolveProvider
	}
}

/// Registration options for document link.
public struct DocumentLinkRegistrationOptions: Codable, Hashable, Sendable {
	/// Whether the server supports work done progress.
	public var workDoneProgress: Bool?
	/// A document selector to identify the scope of the registration, if any.
	public var documentSelector: DocumentSelector?
	/// Whether the server supports resolving additional document link properties.
	public var resolveProvider: Bool?

	/// Creates an instance from its parts.
	public init(
		workDoneProgress: Bool? = nil, documentSelector: DocumentSelector? = nil,
		resolveProvider: Bool? = nil
	) {
		self.workDoneProgress = workDoneProgress
		self.documentSelector = documentSelector
		self.resolveProvider = resolveProvider
	}
}

/// Parameters for the `textDocument/documentLink` request.
public struct DocumentLinkParams: Codable, Hashable, Sendable {
	/// An optional token for work done progress.
	public var workDoneToken: ProgressToken?
	/// An optional token for partial results.
	public var partialResultToken: ProgressToken?

	/// Creates an instance from its parts.
	public init(
		workDoneToken: ProgressToken? = nil, partialResultToken: ProgressToken? = nil
	) {
		self.workDoneToken = workDoneToken
		self.partialResultToken = partialResultToken
	}
}

/// A document link is a range in a text document that links to an internal or external resource.
public struct DocumentLink: Codable, Hashable, Sendable {
	/// The range this link applies to.
	public var range: LSPRange
	/// The URI this link points to.
	public var target: DocumentUri?
	/// The tooltip text when hovering over this link.
	///
	/// - Since: 3.15.0
	public var tooltip: String?
	/// A data entry field that is preserved on a document link between request rounds.
	public var data: LSPAny?

	/// Creates an instance from its parts.
	public init(range: LSPRange, target: DocumentUri?, tooltip: String?, data: LSPAny?) {
		self.range = range
		self.target = target
		self.tooltip = tooltip
		self.data = data
	}
}

/// The response type for `textDocument/documentLink`.
public typealias DocumentLinkResponse = [DocumentLink]?
