//
//  Router.swift
//  Router
//
//  Created by David Hardiman on 02/02/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import UIKit

/// Router describes a contract for navigation through the app.
/// It should be able to route to Destinations, URLs and model objects.
public protocol Router {
    /// - Parameter destination: The destination to be routed to.
    /// - Returns: The view controller that was created and will be routed to.
    @discardableResult
    func route(to destination: Destination) -> UIViewController?

    /// - Parameter target: The target to be routed to.
    /// - Returns: A `Bool` indicating whether routing was successful or not.
    @discardableResult
    func route(to target: RouteTarget) -> Bool

    /// Routes to a URL from an external deep link. Used to allow a
    /// `Route` to specify tighter control over the presentation
    /// hint than the created destination would otherwise offer
    /// when coming from an external deep link
    ///
    /// - Parameter url: The URL to be routed to.
    /// - Returns: A `Bool` indicating whether routing was successful or not.
    func routeFromExternalSource(to url: URL) -> Bool

    /// - Parameter target: The target to be routed to.
    /// - Parameter completion: Block to call when processing the route is complete
    /// - Returns: A `Bool` indicating whether routing was successful or not.
    @discardableResult
    func route(to target: RouteTarget, completion: (() -> Void)?) -> Bool

    /// Instructs the receiver to dismiss whatever destination it has routed to modally.
    ///
    /// - Parameter animated: Whether the dismissal should be animated.
    /// - Parameter completion: The completion to call on successful dismissal.
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Router {
    /// Instructs the receiver to dismiss whatever destination it has routed to modally with animation.
    public func dismiss() {
        dismiss(animated: true, completion: nil)
    }

    /// Instructs the receiver to dismiss whatever destination it has routed to modally.
    ///
    /// - Parameter completion: The completion to call on successful dismissal.
    public func dismiss(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }

    /// - Parameter url: The URL to be routed to.
    /// - Returns: A `Bool` indicating whether routing was successful or not.
    @discardableResult
    public func route(to url: URL) -> Bool {
        return route(to: .url(url))
    }

    /// - Parameter url: The URL to be routed to.
    /// - Parameter completion: Block to call when processing the route is complete
    /// - Returns: A `Bool` indicating whether routing was successful or not.
    @discardableResult
    public func route(to url: URL, completion: (() -> Void)?) -> Bool {
        return route(to: .url(url), completion: completion)
    }
}
