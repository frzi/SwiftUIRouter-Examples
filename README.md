# SwiftUI Router examples

[![SwiftUI](https://img.shields.io/badge/SwiftUI-blue.svg?style=for-the-badge&logo=swift&logoColor=black)](https://developer.apple.com/xcode/swiftui)
[![Swift](https://img.shields.io/badge/Swift-5.5-orange.svg?style=for-the-badge&logo=swift)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-13-blue.svg?style=for-the-badge&logo=Xcode&logoColor=white)](https://developer.apple.com/xcode)

This repository contains examples demonstrating how to utilize path-based routing using the [SwiftUI Router](https://github.com/frzi/SwiftUIRouter) library. These examples are not made to look pretty, but rather, are simplified to better showcase *SwiftUI Router*'s features as well as giving examples on how to structure your routes and code.

## The examples

| Example | Platforms<sup>1,2</sup> | Description |
| ------- | ---------- | ----------- |
| [RandomUsers](RandomUsers) | iOS, macOS | A simple contacts-like app with 100 randomly generated users from [randomuser.me](https://randomuser.me). It demonstrates most of the features *SwiftUI Router* has to offer, how to organize routes and being able to redirect users to different parts of the app with a single button. |
| [Github Explorer](GithubExplorer) | iOS, macOS | A barebones Github client to browse users and repositories. It demonstrates most of *SwiftUI Router*'s features, how to organize routes as well as dealing with asynchronous data. |
| [Swiping](Swiping) | iOS | A featureless app trying to replicate iOS's swipe-to-return navigation. |
| [TabView](TabView) | iOS, macOS | Example of how to combine *SwiftUI Router* and SwiftUI's builtin `TabView`. |

<sup>1</sup> *SwiftUI Router* is available on iOS (and iPadOS), macOS, tvOS and watchOS. Due to the interest of time the examples were only made and tested on iOS and macOS. 🙇  
<sup>2</sup> All projects are made for iOS 15+ or macOS 12+.