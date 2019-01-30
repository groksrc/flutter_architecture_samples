// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:todos_repository_base/todos_repository_base.dart';
import 'package:todos_repository_firebase/todos_repository_firebase.dart';

import 'actions/actions.dart';
import 'containers/add_todo.dart';
import 'localization.dart';
import 'middleware/store_todos_middleware.dart';
import 'models/models.dart';
import 'presentation/home_screen.dart';
import 'reducers/app_state_reducer.dart';


void main([
  TodosRepositoryBase todosRepository,
  UserRepositoryBase userRepository,
]) {
  runApp(ReduxApp(
    todosRepository: todosRepository,
    userRepository: userRepository,
  ));
}

class ReduxApp extends StatelessWidget {
  final Store<AppState> store;

  ReduxApp({
    Key key,
    TodosRepositoryBase todosRepository,
    UserRepositoryBase userRepository,
  })  : store = Store<AppState>(
          appReducer,
          initialState: AppState.loading(),
          middleware: createStoreTodosMiddleware(
            todosRepository ??
                FirebaseTodosRepository(Firestore.instance),
            userRepository ?? FirebaseUserRepository(FirebaseAuth.instance),
          ),
        ),
        super(key: key) {
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: FirestoreReduxLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          FirestoreReduxLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) => HomeScreen(),
          ArchSampleRoutes.addTodo: (context) => AddTodo(),
        },
      ),
    );
  }
}
