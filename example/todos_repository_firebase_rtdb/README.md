# firebase_rtdb_flutter_repository

An implementation of `todos_repository_base` backed by Firebase Realtime Database and FirebaseAuth for Flutter.

## Defines how to log in

This library provides a concrete implementation of the `UserRepositoryBase` class. It uses the `firebase_auth` package and anonymous login as the mechanism and returns a `UserEntity`.

## Defines how to interact with Todos

This library provides a concrete implementation of the `TodosRepositoryBase`.

To listen for real-time changes, it streams `TodoEntity` objects stored in the `todos` collection on
 Firebase Realtime Database. To create, update, and delete todos, it pushes changes to the `todos`
 collection or individual documents.

### Works with `flutter_firestore_redux` project

In `main.dart` replace the current implementation of the abstract `TodosRepositoryBase`
```dart
    FirebaseTodosRepository(Firestore.instance)
```
with
```dart
    FirebaseDatabaseTodosRepository(FirebaseDatabase.instance)
```
Also in `main.dart` replace the `cloud_firestore` package with the `firebase_database` package. Replace
```dart
import 'package:cloud_firestore/cloud_firestore.dart';
```
with
```dart
import 'package:firebase_database/firebase_database.dart';
```
In `pubspec.yaml` replace
```yaml
    todos_repository_firebase:
      path: ../todos_repository_firebase
```
with
```yaml
    todos_repository_firebase_rtdb:
      path: ../todos_repository_firebase_rtdb
```

Then update packages from commandline with
```
flutter packages get
```
or the equivalent with your IDE.
