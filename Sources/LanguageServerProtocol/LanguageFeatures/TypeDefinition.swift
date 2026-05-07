import Foundation

/// Client capabilities for the `textDocument/typeDefinition` request.
public typealias TypeDefinitionClientCapabilities = DynamicRegistrationLinkSupportClientCapabilities

/// The response type for `textDocument/typeDefinition`.
public typealias TypeDefinitionResponse = ThreeTypeOption<Location, [Location], [LocationLink]>?
