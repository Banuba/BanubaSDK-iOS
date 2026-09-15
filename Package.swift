// swift-tools-version:5.9

import PackageDescription

let faceARversionRange: Range<Version> = "1.17.0-beta.0"..<"1.17.99"
let banubaUtilsVersionRange: Range<Version> = "1.54.1"..<"1.59.99"
let banubaCoreVersionRange: Range<Version> = "1.54.1"..<"1.59.99"

let package = Package(
  name: "BanubaSdk",
  platforms: [
    .iOS(.v15)
  ],
  products: [
    .library(
      name: "BanubaSdk",
      targets: ["BanubaSdkTarget"]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/Banuba/BanubaUtilities-iOS.git", banubaUtilsVersionRange),
    .package(url: "https://github.com/Banuba/BanubaVideoEditorCore-iOS.git", banubaCoreVersionRange),

    .package(url: "https://github.com/sdk-banuba/BNBSdkCore.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBSdkApi.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBEffectPlayer.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBScripting.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBLips.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBHair.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBEyes.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBBackground.git", faceARversionRange),
    .package(url: "https://github.com/sdk-banuba/BNBSkin.git", faceARversionRange)
  ],
  targets: [
    .binaryTarget(
      name: "BanubaSdk",
      url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDK/1.54.3/BanubaSdk-1.54.3.xcframework.zip",
      checksum: "4650c1b47a3efd482417d752722273d1c06f2b94fb66393362c0cd88f363f8b3"
    ),
    .target(
      name: "BanubaSdkTarget",
      dependencies: [
        .target(name: "BanubaSdkWrapper")
      ],
      path: "BanubaSdkTarget"
    ),
    .target(
      name: "BanubaSdkWrapper",
      dependencies: [
        .product(name: "BanubaUtilities", package: "BanubaUtilities-iOS"),
        .product(name: "BanubaVideoEditorCore", package: "BanubaVideoEditorCore-iOS"),
        
        "BanubaSdk",
        
        "BNBSdkCore",
        "BNBSdkApi",
        "BNBEffectPlayer",
        "BNBScripting",
        "BNBLips",
        "BNBHair",
        "BNBEyes",
        "BNBBackground",
        "BNBSkin"
      ],
      path: "BanubaSdkWrapper"
    ),
  ]
)
