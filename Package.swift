// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "tuner-package",
  platforms: [
    .iOS(.v16),
    .macOS(.v12), // FIXME: Only for benchmarks
  ],
  products: [
    .library(name: "AudioSessionClient", targets: ["AudioSessionClient"]),
    .library(name: "MicrophoneMonitoringClient", targets: ["MicrophoneMonitoringClient"]),
    .library(name: "PitchDetection", targets: ["PitchDetection"]),
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "TestHelpers", targets: ["TestHelpers"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.1.0"),
    .package(url: "https://github.com/google/swift-benchmark", from: "0.1.0"),
  ],
  targets: [
    .target(
      name: "AudioSessionClient",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "MicrophoneMonitoringClient",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(name: "PitchDetection"),
    .testTarget(
      name: "PitchDetectionTests",
      dependencies: [
        "TestHelpers",
        "PitchDetection",
      ]
    ),
    .target(
      name: "AppFeature",
      dependencies: [
        "AudioSessionClient",
        "MicrophoneMonitoringClient",
        "PitchDetection",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(name: "TestHelpers"),
    .executableTarget(
      name: "PitchDetectionBenchmarks",
      dependencies: [
        "PitchDetection",
        .product(name: "Benchmark", package: "swift-benchmark"),
      ]
    ),
  ]
)
