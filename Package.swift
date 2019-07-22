// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DailyPi",
    dependencies: [
        .package(url: "https://github.com/pvieito/PythonKit.git",
                 .branch("master")),
    ],
    targets: [
        .target(
            name: "DailyPi",
            dependencies: ["PythonKit"]),
//        .testTarget(
//            name: "DailyPiTests",
//            dependencies: ["PythonKit"]),
    ]
)
