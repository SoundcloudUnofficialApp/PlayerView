// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PlayerView",
    platforms: [
        .iOS(.v10)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "PlayerView",
            targets: ["PlayerView"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        
        .target(
            name: "PlayerView",
            dependencies: [],
            exclude: [
                "Example"
            ]
        ),
        // .testTarget(
        //     name: "PlayerViewTests",
        //     dependencies: ["PlayerView"]),
    ],
    swiftLanguageVersions: [.v5]
)
