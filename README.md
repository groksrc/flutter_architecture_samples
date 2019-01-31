# flutter_architecture_samples

[![Build Status](https://travis-ci.org/brianegan/flutter_architecture_samples.svg?branch=master)](https://travis-ci.org/brianegan/flutter_architecture_samples)
[![codecov](https://codecov.io/gh/brianegan/flutter_architecture_samples/branch/master/graph/badge.svg)](https://codecov.io/gh/brianegan/flutter_architecture_samples)

<img align="right" src="assets/todo-list.png" alt="List of Todos Screen">

[TodoMVC](http://todomvc.com) for Flutter!

Flutter provides a lot of flexibility in deciding how to organize and architect your apps. While this freedom is very valuable, it can also lead to apps with large classes, inconsistent naming schemes, as well as mismatching or missing architectures. These types of issues can make testing, maintaining and extending your apps difficult.

The Flutter Architecture Samples project demonstrates strategies to help solve or avoid these common problems. This project implements the same app using different architectural concepts and tools.

You can use the samples in this project as a learning reference, or as a starting point for creating your own apps. The focus of this project is on demonstrating how to structure your code, design your architecture, and the eventual impact of adopting these patterns on testing and maintaining your app. You can use the techniques demonstrated here in many different ways to build apps. Your own particular priorities will impact how you implement the concepts in these projects, so you should not consider these samples to be canonical examples. To ensure the focus is kept on the aims described above, the app uses a simple UI.

### Current Samples

Examples have been updated to Dart 2.

  * [Lifting State Up (Vanilla) Example](example/flutter_vanilla) - Uses the tools Flutter provides out of the box to manage app state.
  * [InheritedWidget Example](example/flutter_inherited_widget) - Uses an InheritedWidget to pass app state down the widget hierarchy.
  * [BLoC Example](example/flutter_blocs) - An implementation of the BLoC pattern, which uses Sinks for Inputs and Streams for Ouputs. Separates the BLoC library from the UI library. Blocs are defined in [flutter_blocs_base](example/flutter_blocs_base).
  * ["Simple" BLoC Example](example/flutter_simple_blocs) - Similar to the BLoC pattern, but uses Functions for Inputs and Streams for Outputs. Results in far less code compared to standard BLoC.
  * [Redux Example](example/flutter_flutter_redux) - Uses the [Redux](https://pub.dartlang.org/packages/redux) and [flutter_redux](https://pub.dartlang.org/packages/flutter_redux) libraries to manage app state and update Widgets
  * [built_redux Example](example/built_redux) - Uses the [built_redux](https://pub.dartlang.org/packages/built_redux) library to enforce immutability and manage app state
  * [scoped_model Example](example/flutter_scoped_model) - Uses the [scoped_model](https://pub.dartlang.org/packages/scoped_model) library to hold app state and notify Widgets of Updates
  * [Firestore Redux Example](example/flutter_firestore_redux) - Uses the [Redux](https://pub.dartlang.org/packages/redux) library to manage app state and update Widgets and
  adds [Cloud_Firestore](https://firebase.google.com/docs/firestore/) as the Todos database.
  * [MVU Example](example/flutter_mvu) - Uses the [dartea](https://pub.dartlang.org/packages/dartea) library to manage app state and update Widgets.
  * [ReduRx Example](example/flutter_flutter_redurx) - Uses the [redurx](https://pub.dartlang.org/packages/redurx) + [flutter_redurx](https://pub.dartlang.org/packages/flutter_redurx) libraries as a new way to handle state using RxDart and StreamBuilder based on a Redux store.
  * [MVI Example](example/flutter_mvi) - Uses the concepts from Cycle.JS and applies them to Flutter.
  * [MVC Example](example/flutter_mvc) - Uses the [MVC](https://pub.dartlang.org/packages/mvc_pattern) library to implement the traditional MVC design pattern.


### Supporting Code

* [todos_repository_base](example/todos_repository_base) - Defines foundational base classes that every implementation should use including the shape of the Repository and Entities.
* [todos_repository_simple](example/todos_repository_simple) - Demonstrates implementing the repository pattern and testing strategies for working with the filesystem. Used to provide local storage and mock web storage to samples.
* [integration_tests](example/integration_tests) - Demonstrates how to write selenium-style integration (aka end to end) tests using the Page Object Model. This test suite is run against all samples.

### Why a todo app?

The app in this project aims to be simple enough that you can understand it quickly, but complex enough to showcase difficult design decisions and testing scenarios. For more information, see the [app's specification](app_spec.md).

### Be excellent to each other

This Repo is meant as a discussion platform for various architectures. Let us debate these ideas vigorously, but let us be excellent to each other in the process!

While healthy debate and contributions are very welcome, trolls are not. Read the [code of conduct](code-of-conduct.md) for detailed information.

### Contributing

Feel free to join in the discussion, file issues, and we'd love to have more samples added! Please read the [CONTRIBUTING](CONTRIBUTING.md) file for guidance :)

### License

All code in this repo is MIT licensed.

## Attribution

All of these ideas and even some of the language are directly influenced by two projects:

  - [TodoMVC](http://todomvc.com) - A Todo App implemented in various JS frameworks
  - [Android Architecture Blueprints](https://github.com/googlesamples/android-architecture) - A similar concept, but for Android! The UI and app spec was highly inspired by their example.

## Contributors

  * [Brian Egan](https://github.com/brianegan)
  * [Maurice McCabe](https://github.com/mmcc007)
  * [David Marne](https://github.com/davidmarne)
  * [Pascal Welsch](https://github.com/passsy)
  * [Larry King](https://github.com/kinggolf)
  * [Frank Harper](https://github.com/franklinharper)
  * [Pavel Shilyagov](https://github.com/p69)
  * [Leo Cavalcante](https://github.com/leocavalcante)
  * [Greg Perry](https://github.com/AndriousSolutions)
  * [Drew Cain](https://github.com/groksrc)

I'd like to thank all of the folks who have helped write new samples, improve the current implementations, and added documentation! You're amazing! :)
