import Foundation

/// Client capabilities for the `textDocument/definition` request.
public typealias DefinitionClientCapabilities = DynamicRegistrationLinkSupportClientCapabilities

/// The response type for `textDocument/definition`.
public typealias DefinitionResponse = ThreeTypeOption<Location, [Location], [LocationLink]>?
