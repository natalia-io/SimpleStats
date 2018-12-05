# SimpleStats

[![CI Status](https://img.shields.io/travis/natalia-io/SimpleStats.svg?style=flat)](https://travis-ci.org/natalia-io/SimpleStats)
[![Version](https://img.shields.io/cocoapods/v/SimpleStats.svg?style=flat)](https://cocoapods.org/pods/SimpleStats)
[![License](https://img.shields.io/cocoapods/l/SimpleStats.svg?style=flat)](https://cocoapods.org/pods/SimpleStats)
[![Platform](https://img.shields.io/cocoapods/p/SimpleStats.svg?style=flat)](https://cocoapods.org/pods/SimpleStats)

## Example

## Example

Usage is very simple. After installation, write at the top of your file:
```
import SimpleStats
```
From then on, you can call functions such as .avg(), .sd(), .variance(), etc. on arrays of type [Double] and [Int], like so:

```
var xValues:[Double] = [7.5,8.8,9.3,8.1,6,8,7,5.9,2.3,7]
var yValues:[Double] = [203,345,174,245,235,864,356,668,847,905]
print(xValues.avg())
print(yValues.avg())
//6.99
//484.2
```
Create a dictionary from two arrays with the same count and you can easily calculate correlation:
```
var dictionary = [Double:Double]()

for i in xValues.indices {
    dictionary[xValues[i]] = yValues[i]
}

var correlation = dictionary.r()
print(correlation)

//-0.4980879419156199
```


## Requirements

## Installation

SimpleStats is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'SimpleStats'
```

## Author

Natália Mendonça, natalia@smartmood.io

## License

SimpleStats is available under the MIT license. See the LICENSE file for more info.
