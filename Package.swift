// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KeyCryption",
    products: [
        .library(
            name: "KeyCryption",
            targets: ["KeyCryption"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "KeyCryption",
            dependencies: []),
        .testTarget(
            name: "KeyCryptionTests",
            dependencies: ["KeyCryption"]),
    ]
)
