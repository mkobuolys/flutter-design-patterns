[![flutterdesignpatterns.com deployment](https://github.com/mkobuolys/flutter-design-patterns/actions/workflows/main.yml/badge.svg)](https://github.com/mkobuolys/flutter-design-patterns/actions/workflows/main.yml)

# Flutter Design Patterns

An open-source [OOP design patterns](https://en.wikipedia.org/wiki/Design_Patterns) application built with Dart and Flutter.

https://flutterdesignpatterns.com/

This application is an implementation part of the "Flutter Design Patterns" [article series](https://kazlauskas.dev/flutter-design-patterns-0-introduction).

<p float="left">
	<img src="./images/home.png" alt="Home Page" width="250">
	<img src="./images/creational.png" alt="Creational Design Patterns" width="250">
	<img src="./images/structural.png" alt="Structural Design Patterns" width="250">
	<img src="./images/behavioral.png" alt="Behavioral Design Patterns" width="250">
    <img src="./images/markdown.png" alt="Design Pattern Markdown" width="250">
	<img src="./images/flyweight.png" alt="Flyweight Design Pattern Example" width="250">
	<img src="./images/command.png" alt="Command Design Pattern Example" width="250">
	<img src="./images/iterator.png" alt="Iterator Design Pattern Example" width="250">
	<img src="./images/prototype.png" alt="Prototype Design Pattern Example" width="250">
</p>

## Building

You can follow these instructions to build the app and install it onto your device.

### Prerequisites

If you are new to Flutter, please first follow the [Flutter Setup](https://flutter.dev/setup/) guide.

### Building and installing the Flutter Design Patterns app

```
git clone https://github.com/mkobuolys/flutter-design-patterns.git
cd flutter-design-patterns
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

The `flutter run` command both builds and installs the Flutter app to your device or emulator.
