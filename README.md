# QRCode Client

This is a project made with Flutter that features a QR-Code client which generates and validates them.

This project works alongside with [this backend](http://github.com/rodriigovieira/qrcode-generator/), and you will need to follow the instructions in the other project to be able to run this project.

## Project Structure

```
lib
│   main.dart
│   constants.dart    
│
└───screens
│   └───HomePage
│       │   home_page.dart
│       └───components
│           │   ...
│   └───ScanPage
│       │   scan_page.dart
│       │   scan_controller.dart
│       └───components
│           │   ...
│   └───QRCodePage
│       │   qr_code_page.dart
│       │   qr_code_controller.dart
│       │   ...
│   
└───models
    │   seed_model.dart
    │   verification_model.dart
```

The project is using `provider` to manage its state. All the business logic is separated from the UI.

Each page contains a _controller_ file, where all the logic is handled. The exception here is the HomePage, as there isn't any business logic in that page.

Each page also will have upon necessity a folder called `components`, where all the widgets are extracted and organized. This will facilitate the re-usability of the widgets and scalability of the project.

*constants.dart*: file to facilitate the organization of constant variables, such as strings and common elements. This avoids repetition and typos, plus making it easier to apply changes in the future.
*models/*: schematization of our business logic. The responses from the API are schematized at this folder to facilitate its use in the future. A tool called JSON to Dart was used to generate the helper methods.

## Installing the project

This section will assume two things:

1. You have installed and configured the Flutter framework. If you haven't done that yet, [check the Flutter documentation.](https://flutter.dev/docs/get-started/install)
2. You have installed and configured the backend of this project. Any other backend would work as well, as long as it follows the same specifications. If you haven't done that yet, [check the backend repository](https://github.com/rodriigovieira/qrcode-generator/).

First, clone this repository:

```
git clone https://github.com/rodriigovieira/qrcode-client
```

Go to the project's directory:

```
cd qrcode-client
```

Install the project's dependencies:

```
flutter pub get
```

Then, finally, run the project on your preferred device.

```
flutter run
```

