// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:todos_repository_base/todos_repository_base.dart';

import '../actions/actions.dart';
import '../models/models.dart';
import '../selectors/selectors.dart';

List<Middleware<AppState>> createStoreTodosMiddleware(
  TodosRepositoryBase todosRepository,
  UserRepositoryBase userRepository,
) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      _firestoreSignIn(userRepository),
    ),
    TypedMiddleware<AppState, ConnectToDataSourceAction>(
      _firestoreConnect(todosRepository),
    ),
    TypedMiddleware<AppState, AddTodoAction>(
      _firestoreSaveNewTodo(todosRepository),
    ),
    TypedMiddleware<AppState, DeleteTodoAction>(
      _firestoreDeleteTodo(todosRepository),
    ),
    TypedMiddleware<AppState, UpdateTodoAction>(
      _firestoreUpdateTodo(todosRepository),
    ),
    TypedMiddleware<AppState, ToggleAllAction>(
      _firestoreToggleAll(todosRepository),
    ),
    TypedMiddleware<AppState, ClearCompletedAction>(
      _firestoreClearCompleted(todosRepository),
    ),
  ];
}

void Function(
  Store<AppState> store,
  InitAppAction action,
  NextDispatcher next,
) _firestoreSignIn(
  UserRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);

    repository.login().then((_) {
      store.dispatch(ConnectToDataSourceAction());
    });
  };
}

void Function(
  Store<AppState> store,
  ConnectToDataSourceAction action,
  NextDispatcher next,
) _firestoreConnect(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);

    repository.todos().listen((todos) {
      store.dispatch(LoadTodosAction(todos.map(Todo.fromEntity).toList()));
    });
  };
}

void Function(
  Store<AppState> store,
  AddTodoAction action,
  NextDispatcher next,
) _firestoreSaveNewTodo(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);
    repository.addNewTodo(action.todo.toEntity());
  };
}

void Function(
  Store<AppState> store,
  DeleteTodoAction action,
  NextDispatcher next,
) _firestoreDeleteTodo(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);
    repository.deleteTodo([action.id]);
  };
}

void Function(
  Store<AppState> store,
  UpdateTodoAction action,
  NextDispatcher next,
) _firestoreUpdateTodo(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);
    repository.updateTodo(action.updatedTodo.toEntity());
  };
}

void Function(
  Store<AppState> store,
  ToggleAllAction action,
  NextDispatcher next,
) _firestoreToggleAll(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);
    var todos = todosSelector(store.state);

    for (var todo in todos) {
      if (allCompleteSelector(todos)) {
        if (todo.complete)
          repository.updateTodo(todo.copyWith(complete: false).toEntity());
      } else {
        if (!todo.complete)
          repository.updateTodo(todo.copyWith(complete: true).toEntity());
      }
    }
  };
}

void Function(
  Store<AppState> store,
  ClearCompletedAction action,
  NextDispatcher next,
) _firestoreClearCompleted(
  TodosRepositoryBase repository,
) {
  return (store, action, next) {
    next(action);

    repository.deleteTodo(
      completeTodosSelector(todosSelector(store.state))
          .map((todo) => todo.id)
          .toList(),
    );
  };
}
