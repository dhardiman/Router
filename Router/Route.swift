//
//  Route.swift
//  Router
//
//  Created by Luciano Marisi on 14/02/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import Foundation

public typealias DestinationResult = Result<Destination, Error>

/// Route describes a conversion from a URL or model object to a destination.
public protocol Route: AnyObject {
    init()

    /// Suggested hint for overriding a created destination's hint
    /// when routing via an external source
    var presentationHint: PresentationHint? { get }
}

/// URLRoute describes the conversion from a URL to a Destination.
/// The API allows for that conversion to be asynchronous in case a look up is
/// required to find the destination
public protocol URLRoute: Route {
    /// Should inspect the URL to decide if the url can be converted to a destination.
    ///
    /// - Parameter url: The URL to check
    static func canHandle(url: URL) -> Bool

    /// Attempts to create a destination from the passed in URL
    ///
    /// - Parameters:
    ///   - url: The URL to look up
    ///   - callback: The closure to call when the look up completes
    func destination(for url: URL, callback: @escaping (DestinationResult) -> Void)
}

/// ObjectRoute describes the conversion from an object to a Destination.
/// The API allows for that conversion to be asynchronous in case a look up is
/// required to find the destination
public protocol ObjectRoute: Route {
    /// Should inspect the object to decide if the object can be converted to a destination.
    ///
    /// - Parameter object: The object to check
    static func canHandle(object: Any) -> Bool

    /// Attempts to create a destination from the passed in object
    ///
    /// - Parameters:
    ///   - target: The object to look up
    ///   - callback: The closure to call when the look up completes
    func destination(for object: Any, callback: @escaping (DestinationResult) -> Void)
}
