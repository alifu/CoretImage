# CoretImage

[![CI Status](https://img.shields.io/travis/alifu/CoretImage.svg?style=flat)](https://travis-ci.org/alifu/CoretImage)
[![Version](https://img.shields.io/cocoapods/v/CoretImage.svg?style=flat)](https://cocoapods.org/pods/CoretImage)
[![License](https://img.shields.io/cocoapods/l/CoretImage.svg?style=flat)](https://cocoapods.org/pods/CoretImage)
[![Platform](https://img.shields.io/cocoapods/p/CoretImage.svg?style=flat)](https://cocoapods.org/pods/CoretImage)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

- Min. iOS 10
- Swift 5

## Installation

CoretImage is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CoretImage'
```

## Documentation

|Function|Description|
|---|---|
|```.applyImage(_)```|Apply image as background, with ```UIImage?``` param|
|```.applyLineWidth(_)```|Apply line width of shape, with ```CGFloat``` param|
|```.applyStrokeColor(_)```|Apply CGColor of shape, with ```CGColor?``` param|
|```.undoLastStroke()```|Remove the last stroke|
|```.getResultImage()```|Get Image Result|

## How to use

#### Initialization

```swift
let coretView = CoretView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
self.view.subView(coretView)
self.coretView.applyImage(with: UIImage(named: "leaves"))
```

#### Apply line width (default is 2.0)

```swift
self.coretView.applyLineWidth(with: 5.0)
```

#### Apply stroke color (default is red)

```swift
self.coretView.applyStrokeColor(with: UIColor.yellow.cgColor)
```

#### Undo last stroke

```swift
self.coretView.undoLastStroke()
```

#### Get result image as ```UIImage?```

```swift
let resultImage = coretView.getResultImage()
```

## Author

alifu

## Resources

[Leaves image](https://www.pexels.com/id-id/foto/close-up-embun-di-daun-hijau-di-hutan-lebat-28624741/)

## License

CoretImage is available under the MIT license. See the LICENSE file for more info.
