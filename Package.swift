// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.
//test1

import PackageDescription

let package = Package(
    name: "MyAwesomeProject",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-MySQL.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", from: "3.0.0"),
//        .package(url: "https://github.com/PerfectlySoft/Perfect-Logger.git", from: "3.0.0"),
        .package(url: "https://github.com/PerfectlySoft/Perfect-Markdown.git", from: "3.0.0"),
//        .package(url: "https://github.com/iamjono/SwiftString.git", from: "2.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MyAwesomeProject",
            dependencies: ["PerfectHTTPServer", "PerfectMySQL", "PerfectMustache", "PerfectMarkdown"]),
        .testTarget(
            name: "MyAwesomeProjectTests",
            dependencies: ["MyAwesomeProject"]),
    ]
)
