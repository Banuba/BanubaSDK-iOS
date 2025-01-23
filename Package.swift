// swift-tools-version:5.9

import PackageDescription

let faceARversionRange: Range<Version> = "1.16.0"..<"1.16.3"
let videoEditorSDKRange: Range<Version> = "1.39.0"..<"1.49.99"

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
  dependencies: [
    .package(url: "https://github.com/sdk-banuba/BNBSdkCore.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBSdkApi.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBEffectPlayer.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBScripting.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBLips.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBHair.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBEyes.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBBackground.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBSkin.git", faceARversionRange),
    
    .package(url: "https://github.com/Banuba/BanubaUtilities-iOS.git", videoEditorSDKRange),
    .package(url: "https://github.com/Banuba/BanubaVideoEditorCore-iOS.git", videoEditorSDKRange)
  ],
  targets: [
    .binaryTarget(
      name: "BanubaSdk",
      path: "BanubaSdk.xcframework"
    )
  ]
)
