// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormKit",
    platforms: [
        .iOS(.v14), .macOS(.v11)
    ],
    products: [
        .library(name: "FormKit", targets: ["FormKit"]),
    ],
    targets: [
        .target(name: "FormKit"),
        .testTarget(name: "FormKitTests", dependencies: ["FormKit"]),
    ]
)
