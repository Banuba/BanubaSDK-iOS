// swift-tools-version:5.9

import PackageDescription

let faceARversionRange: Range<Version> = "1.17.2"..<"1.17.99"
let version: Version = "1.48.1"

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
    .package(url: "https://github.com/Banuba/BanubaUtilities-iOS.git", exact: version),
    .package(url: "https://github.com/Banuba/BanubaVideoEditorCore-iOS.git", exact: version),
    
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
      path: "BanubaSdk.xcframework"
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
