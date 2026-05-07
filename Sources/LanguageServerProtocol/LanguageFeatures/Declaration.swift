//
//  File.swift
//
//
//  Created by Matthew Massicotte on 2022-02-17.
//

import Foundation

/// Client capabilities for the `textDocument/declaration` request.
///
/// - Since: 3.14.0
public typealias DeclarationClientCapabilities = DynamicRegistrationLinkSupportClientCapabilities

/// The response type for `textDocument/declaration`.
public typealias DeclarationResponse = ThreeTypeOption<Location, [Location], [LocationLink]>?
