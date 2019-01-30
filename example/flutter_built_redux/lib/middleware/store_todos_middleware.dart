// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:built_redux/built_redux.dart';

import '../actions/actions.dart';
import '../data/todos_storage.dart';
import '../models/models.dart';

Middleware<AppState, AppStateBuilder, AppActions> createStoreTodosMiddleware([
  TodosStorage repository = const TodosStorage(),
]) {
  return (MiddlewareBuilder<AppState, AppStateBuilder, AppActions>()
        ..add(AppActionsNames.fetchTodosAction, createFetchTodos(repository))
        ..add(AppActionsNames.addTodoAction, createSaveTodos<Todo>(repository))
        ..add(AppActionsNames.clearCompletedAction,
            createSaveTodos<Null>(repository))
        ..add(AppActionsNames.loadTodosSuccess,
            createSaveTodos<List<Todo>>(repository))
        ..add(AppActionsNames.deleteTodoAction,
            createSaveTodos<String>(repository))
        ..add(
            AppActionsNames.toggleAllAction, createSaveTodos<Null>(repository))
        ..add(AppActionsNames.updateTodoAction,
            createSaveTodos<UpdateTodoActionPayload>(repository)))
      .build();
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, Null> createFetchTodos(
    TodosStorage repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<Null> action) {
    if (api.state.isLoading) {
      repository.loadTodos().then((todos) {
        return api.actions.loadTodosSuccess(todos);
      }).catchError(api.actions.loadTodosFailure);
    }

    next(action);
  };
}

MiddlewareHandler<AppState, AppStateBuilder, AppActions, T> createSaveTodos<T>(
    TodosStorage repository) {
  return (MiddlewareApi<AppState, AppStateBuilder, AppActions> api,
      ActionHandler next, Action<T> action) {
    next(action);

    repository.saveTodos(api.state.todos.toList());
  };
}
