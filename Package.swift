// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "EmptyStateKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "EmptyStateKit",
            targets: ["EmptyStateKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "EmptyStateKit",
            dependencies: []
        ),
        .testTarget(
            name: "EmptyStateKitTests",
            dependencies: ["EmptyStateKit"]),
    ]
)
