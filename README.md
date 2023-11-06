# apex
![Language](https://img.shields.io/badge/language-Swift%205.4-orange.svg)
[![GitHub followers](https://img.shields.io/github/followers/olsamaja.svg?style=social&label=Follow&style=flat-square)]()

A very sample app developed in Swift, which I use as a playground to test frameworks, design patterns and some other tricks.

## Features

- [x] View apps rating and reviews
- [x] Add new apps as favorites

## Requirements

- iOS 16.0+
- Xcode 14.1

## Installation


To get started, clone this repository.

```
git clone https://github.com/olsamaja/apex.git
```

## Project Structure

The Xcode workspace contains the following projects.

    ├─ Apex
    ├─ ApexViewModule
    ├─ ApexSearchModule
    ├─ ApexStoreModule
    ├─ ApexSettingsModule
    ├─ ApexNetwork
    ├─ ApexConfiguration
    ├─ ApexCoreUI
    ├─ ApexCore

### Views Hierarchy

+- ApexApp
	+- AppsView
		+- (NavigationStack)
			+- AppsContentView
				+- (List)
					+- AppRow
				+- (NavigationDestination)
					+- AppView
		+- (Sheet)
			+- SelectAppStoreView

