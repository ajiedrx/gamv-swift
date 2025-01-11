// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FavoritePackage",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FavoritePackage",
            targets: ["FavoritePackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ajiedrx/gamv-core-module.git", branch: "main"),
        .package(path: "../CommonPackage")
    ],
    targets: [
            .target(
                name: "FavoritePackage",
                dependencies: [
                    .product(name: "CorePackage", package: "gamv-core-module"),
                    "CommonPackage"]
            ),
        ]
)
