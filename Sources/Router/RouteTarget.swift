//
//  RouteTarget.swift
//  Router
//
//  Created by Sebastian Skuse on 09/01/2018.
//  Copyright © 2018 David Hardiman. All rights reserved.
//

import Foundation

/// The target to attempt to route to.
///
/// - url: A URL target to route to.
/// - model: A model object to route to.
public enum RouteTarget {
    case url(URL)
    case model(Any)
}

public enum RouteTargetError: Error {
    case modelNotSupported
    case invalidRouteType
}
