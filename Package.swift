// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let featureFlags: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete"),
    .enableUpcomingFeature("StrictConcurrency=complete"),
]

let package = Package(
    name: "iankoex",
    platforms: [
        .macOS(.v14),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-rc.2"),
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.4.0"),
        .package(url: "https://github.com/sliemeobn/elementary.git", from: "0.1.2"),
        .package(url: "https://github.com/hummingbird-community/hummingbird-elementary.git", from: "0.1.0-rc.1"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "Elementary", package: "elementary"),
                .product(name: "HummingbirdElementary", package: "hummingbird-elementary"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "AppTests",
            dependencies: [
                .target(name: "App"),
//                .product(name: "HummingbirdXCT", package: "hummingbird"),
            ]
        ),
    ]
)
