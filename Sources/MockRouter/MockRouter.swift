//
//  MockRouter.swift
//  MockRouter
//
//  Created by David Hardiman on 26/09/2019.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import Foundation
import Hopoate
import Router

public class MockRouter: Router {
    public var routeResponse: UIViewController = UIViewController()
    public var receivedDestinations = [Destination]()
    public var receivedTargets = [RouteTarget]()
    public var vendRealController = false
    public private(set) var vendedControllers: [UIViewController] = []
    public var receivedDestination: Destination? {
        return receivedDestinations.last
    }

    public func typedReceivedDestination<T: Destination>(_ type: T.Type) -> T? {
        return receivedDestination as? T
    }

    public private(set) var receivedDismissMessage = false

    public init() {}

    @discardableResult
    public func route(to destination: Destination) -> UIViewController? {
        receivedDestinations.append(destination)
        guard vendRealController else {
            return routeResponse
        }
        let controller = destination.destination
        vendedControllers.append(controller)
        return controller
    }

    public var receivedURL: URL? {
        guard let target = receivedTarget, case let .url(url) = target else {
            return nil
        }
        return url
    }

    public var receivedModel: Any? {
        guard let target = receivedTarget, case let .model(model) = target else {
            return nil
        }
        return model
    }

    private var receivedTarget: RouteTarget? {
        return receivedTargets.last
    }

    public func route(to target: RouteTarget) -> Bool {
        receivedTargets.append(target)
        return false
    }

    public var receivedCompletion: (() -> Void)?
    public func route(to target: RouteTarget, completion: (() -> Void)?) -> Bool {
        receivedTargets.append(target)
        receivedCompletion = completion
        return false
    }

    public var receivedExternalURL: URL?
    public func routeFromExternalSource(to url: URL) -> Bool {
        receivedExternalURL = url
        return false
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        receivedDismissMessage = true
        completion?()
    }

    public static func performTests(with testingClosure: (MockRouter) -> Void) {
        try? performThrowingTests(with: testingClosure)
    }

    public static func performThrowingTests(with testingClosure: (MockRouter) throws -> Void) throws {
        let (mockRouter, registration) = registeredMockRouter()
        try testingClosure(mockRouter)
        DependencyContainer.shared.remove(registration)
    }

    public static func registeredMockRouter() -> (MockRouter, ServiceRegistration<Router>) {
        let mockRouter = MockRouter()
        let mockRouterServiceRegistration = DependencyContainer.shared.register(service: Router.self) {
            mockRouter
        }
        return (mockRouter, mockRouterServiceRegistration)
    }

    public static func unregister(routerRegistration: ServiceRegistration<Router>) {
        DependencyContainer.shared.remove(routerRegistration)
    }
}
