import Foundation

/// The response type for `textDocument/implementation`.
public typealias ImplementationResponse = ThreeTypeOption<Location, [Location], [LocationLink]>?

/// Client capabilities for the `textDocument/implementation` request.
public typealias ImplementationClientCapabilities = DynamicRegistrationLinkSupportClientCapabilities
