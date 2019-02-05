//
//  Route.swift
//  Router
//
//  Created by David Hardiman on 02/02/2017.
//  Copyright © 2017 David Hardiman. All rights reserved.
//

import UIKit

/// Protocol describing the index of a tab within a tab controller
public protocol TabIndexable {
    var rawValue: Int { get }
}

/// The presentation styles used to hint at how a destination's view controller should be presented.
///
/// - navigate: The view controller should be presented in accordance with the current view controller hierarchy, e.g pushed on to a navigation stack within a navigation controller.
/// - modal: The view controller should be presented modally to the user.
/// - tab: The view controller should be presented on the tab specified. Assuming the tab is hosting a navigation controller, once the tab has changed, the `navigate` behaviour will be followed
/// - replaceTab: The view controller should be presented in the tab specified by replacing the current root view controller. If `shouldSwitch` is true the user should also navigate to that tab, else the user should remain in their current location
public enum PresentationHint {
    case navigate
    case modal(metrics: ModalPresentationMetrics)
    case tab(index: TabIndexable)
    case replaceTab(index: TabIndexable, shouldSwitch: Bool)
}

extension PresentationHint: CustomStringConvertible {
    public var description: String {
        switch self {
        case .navigate:
            return "navigate"
        case let .modal(metrics):
            return "modal - animated: \(metrics.animated), style: \(metrics.style.styleDescription)"
        case let .tab(index):
            return "tab - index: \(index)"
        case let .replaceTab(index, shouldSwitch):
            return "replaceTab - index: \(index), shouldSwitch: \(shouldSwitch)"
        }
    }
}

public struct ModalPresentationMetrics: Equatable {
    public let animated: Bool
    public let style: UIModalPresentationStyle?

    public init(animated: Bool = true, style: UIModalPresentationStyle? = nil) {
        self.animated = animated
        self.style = style
    }
}

/// Defines a view controller target. Instances should be able to instantiate the target view controller with all of its dependencies
public protocol Destination {
    /// The view controller to show
    var destination: UIViewController { get }

    /// How the presentation of `destination` should be handled
    /// Read/write so it can be overwritten should some part of the routing
    /// process have more knowledge over the suitable context.
    var presentationHint: PresentationHint { get set }
}

extension PresentationHint: Equatable {
    public static func == (lhs: PresentationHint, rhs: PresentationHint) -> Bool {
        switch (lhs, rhs) {
        case (.navigate, .navigate):
            return true
        case let (.modal(lhsMetrics), .modal(rhsMetrics)):
            return lhsMetrics == rhsMetrics
        case let (.tab(lhsIndex), .tab(rhsIndex)):
            return lhsIndex.rawValue == rhsIndex.rawValue
        case let (.replaceTab(lhsIndex, lhsShouldSwitch), .replaceTab(rhsIndex, rhsShouldSwitch)):
            return lhsIndex.rawValue == rhsIndex.rawValue && lhsShouldSwitch == rhsShouldSwitch
        default:
            return false
        }
    }
}

extension Optional where Wrapped == UIModalPresentationStyle {
    var styleDescription: String {
        guard case let .some(style) = self else { return "none" }
        switch style {
        case .fullScreen:
            return "fullScreen"
        case .pageSheet:
            return "pageSheet"
        case .formSheet:
            return "formSheet"
        case .currentContext:
            return "currentContext"
        case .custom:
            return "custom"
        case .overFullScreen:
            return "overFullScreen"
        case .overCurrentContext:
            return "overCurrentContext"
        case .popover:
            return "popover"
        case .none:
            return "none"
        }
    }
}
