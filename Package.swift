// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISActionSheet",
    products: [
        .library(
            name: "ISActionSheet",
            targets: ["ISActionSheet"]),
    ],
    targets: [
        .target(
            name: "ISActionSheet",
            dependencies: [],
            path: "ISActionSheet"),
    ]
)
