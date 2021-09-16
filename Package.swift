// swift-tools-version:5.3
import PackageDescription
let package = Package(
  name: "BanubaSdk",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(
      name: "BanubaSdk",
      targets: ["BanubaSdk"])
  ],
  targets: [
    .binaryTarget(
      name: "BanubaSdk",
      path: "BanubaSdk.xcframework")
  ])
