// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "BanubaSdk",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "BanubaSdk",
      targets: ["BanubaSdk"])
  ],
  targets: [
    .binaryTarget(
      name: "BanubaSdk",
      path: "BanubaSdk.xcframework"
    )
  ]
)
