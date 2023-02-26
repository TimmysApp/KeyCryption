// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeyCryption",
    platforms: [
        .iOS(.v16),
        .macOS(.v12)
    ],
    products: [
        .library(
            name: "KeyCryption",
            targets: ["KeyCryption"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ikhvorost/KeyValueCoding", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "KeyCryption",
            dependencies: [
                .product(name: "KeyValueCoding", package: "KeyValueCoding")
            ]),
        .testTarget(
            name: "KeyCryptionTests",
            dependencies: ["KeyCryption"]),
    ]
)
