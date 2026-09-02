// swift-tools-version:5.9

import PackageDescription

let faceARversionRange: Range<Version> = "1.17.0-beta.0"..<"1.17.99"
let banubaUtilsVersionRange: Range<Version> = "1.54.2"..<"1.59.99"
let banubaCoreVersionRange: Range<Version> = "1.54.2"..<"1.59.99"

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
      url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDK/1.54.1/BanubaSdk-1.54.1.xcframework.zip",
      checksum: "c47c3c09fa5631f055896008d2e0f235782a29c43f454e68d9114b84e1d66218"
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
