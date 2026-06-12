// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "fix-macosx-internal-sdk",
    platforms: [
        .macOS("13.0"),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "0.4.0")),
        .package(url: "https://github.com/tuist/XcodeProj.git", .upToNextMajor(from: "9.13.0")),
    ],
    targets: [
        .target(
            name: "fix-macosx-internal-sdk",
            dependencies: [
                "XcodeProj",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
    ]
)
