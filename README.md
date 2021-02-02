# QRCode Client

This is a project made with Flutter that features a QR-Code client which generates and validates them.

This project works alongside with [this backend](http://github.com/rodriigovieira/qrcode-generator/), and you will need to follow the instructions in the other project to be able to run this project.

## Project Structure

```
lib
│   main.dart
│   constants.dart    
└───screens
│   └───ExamplePage
│       │   example_page.dart
│       │   example_controller.dart
│       └───components
│           │   ...
└───models
    │   ...
└───services
    │   ...
└───repositories
    │   ...
└───interfaces
    │   ...
```

The project is using `provider` to manage its state, and `get_it` to inject its dependencies. All the business logic is separated from the UI.

Each page contains a _controller_ file, where all the logic is handled. The exception here is the HomePage, as there isn't any business logic in that page.

Each page also will have upon necessity a folder called `components`, where all the widgets are extracted and organized. This will facilitate the re-usability of the widgets and scalability of the project.

**constants.dart**: file to facilitate the organization of constant variables, such as strings and common elements. This avoids repetition and typos, plus making it easier to apply changes in the future.

**models/**: schematization of our business logic. The responses from the API are schematized at this folder to facilitate its use in the future. A tool called JSON to Dart was used to generate the helper methods.

**interfaces/**: they provide a schema to be followed by other classes that wish to implement them. They makes it easier to test and debug the code in the long run.

**repositories/**: they are a bridge between the client and the controllers. In our case, API calls are being handled here and then being passed to the controller so that it can pass the changes to the view. It's another way of futher separating concerns in the project.

**services/**: external services such as location, API clients, data-persistance solutions and etc are defined here.

The services and repositories are injected as dependencies using the `get_it` package. This way, they are avaibale throughout the entire project without needing to instantiace them several times.

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

## Testing the project

To test the project, first follow all the instructions above on how to install it.

Then, simply run the command:

```
flutter test
```

It should work out of the box - no additional setup is required to run the tests.

## Running the app

By default, the app will try to connect to the address `https://qrcode-generator-backend-app.herokuapp.com` - that's where the live version of the backend is deployed. However, feel free to change it to any other address/port of your preference.

You can change it in the `constants.dart` file, changing the `kAPIBaseUrl` variable.
