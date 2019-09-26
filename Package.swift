// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Router",
    products: [
        .library(name: "Router", targets: ["Router"]),
        .library(name: "MockRouter", targets: ["MockRouter"])
    ],
    dependencies: [],
    targets: [
        .target(name: "Router", dependencies: []),
        .target(name: "MockRouter", dependencies: ["Router"])
    ],
    swiftLanguageVersions: [.v5]
)
