// swift-tools-version:5.9

import PackageDescription

let faceARversionRange: Range<Version> = "1.17.0"..<"1.17.99"
let banubaUtilsVersionRange: Range<Version> = "1.53.0"..<"1.53.99"
let banubaCoreVersionRange: Range<Version> = "1.53.0"..<"1.53.99"

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
    // Local development uses the path-based binaryTarget below.
    // Release flow (fastlane patch_package_swift_for_nexus) replaces it in the GitHub distribution repo with:
    // .binaryTarget(
    //   name: "BanubaSdk",
    //   url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDK/{version}/BanubaSdk-{version}.xcframework.zip",
    //   checksum: "{computed at release}"
    // )
    .binaryTarget(
      name: "BanubaSdk",
      url: "https://nexus.banuba.net/repository/ios-frameworks/ios/frameworks/BanubaSDK/1.53.0-beta.1/BanubaSdk-1.53.0-beta.1.xcframework.zip",
      checksum: "dc54ec4335183958f9bf9a28f7d5768efdb23c724ee37a0657a2ffce87b3e2cb"
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
