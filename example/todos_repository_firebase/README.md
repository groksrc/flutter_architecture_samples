# todos_repository_firebase

An implementation of `todos_repository_base` backed by Firestore and FirebaseAuth for Flutter.

## Defines how to log in

This library provides a concrete implementation of the `UserRepositoryBase` class. It uses the `firebase_auth` package and anonymous login as the mechanism and returns a `UserEntity`.

## Defines how to interact with Todos

This library provides a concrete implementation of the `TodosRepositoryBase`.

To listen for real-time changes, it streams `TodoEntity` objects stored in the `todos` collection on Firestore. To create, update, and delete todos, it pushes changes to the `todos` collection or individual documents.
