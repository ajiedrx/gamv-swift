// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CommonPackage",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "CommonPackage",
            targets: ["CommonPackage"]),
    ],
    dependencies: [
        .package(url: "https://github.com/ajiedrx/gamv-core-module.git", branch: "main"),
    ],
    targets: [
            .target(
                name: "CommonPackage",
                dependencies: [
                    .product(name: "CorePackage", package: "gamv-core-module"),
                ]),  
        ]
)
