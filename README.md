# Shares-App

### Summary

- [Requirements](#requirements)
- [Installation](#installation)
- [Description](#description)

## Requirements
- Xcode installed
- CocoaPods

## Installation

Run this command in terminal:
```
pod install
```

## Description

This application was developed using MVVM-C and RxSwift.
The views were created using only code with the help of SnapKit to create the constraints.
One module in the app is basically composed by 3 files:

- View: It is the viewController, responsible to handle the lifecycle of the app and intermediate the viewModel and the viewScreen

- ViewModel: It is the file that holds the logics and transformation of data. 

- ViewScreen: It is a class that defines the construction of the View. No logic is held on that. 

The classes are binded by RxSwift that also helps on the asyncronous calls alongside Moya.

The navigation flow is using a Coordinator class, that is responsible for 
show the modules.

Swinject is used in this project for dependency injection.

For the unit tests Quick and Nimble were used.

For the UI tests KIF was used.

Best Regards,

Leonardo Augusto Piovezan
