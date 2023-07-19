// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SystemServices",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SystemServices",
            targets: [
                "SystemServices"
            ]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/securing/IOSSecuritySuite.git", from: "1.9.9"),
    ],
    targets: [
        .target(
            name: "SystemServices",
            dependencies: ["IOSSecuritySuite"],
            path: "SystemServices"
        )
    ]
)
