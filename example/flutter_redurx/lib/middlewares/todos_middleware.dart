import 'package:flutter_redurx/flutter_redurx.dart';

import '../actions/add_todo.dart';
import '../actions/clear_completed.dart';
import '../actions/delete_todo.dart';
import '../actions/fetch_todos.dart';
import '../actions/toggle_all_complete.dart';
import '../actions/update_todo.dart';
import '../data/todos_repository.dart';
import '../models/app_state.dart';

class TodosMiddleware extends Middleware<AppState> {
  final TodosRepository _todosRepository;

  TodosMiddleware(this._todosRepository);

  @override
  AppState beforeAction(ActionType action, AppState state) {
    if (action is FetchTodos) {
      action.todosRepository = _todosRepository;
    }

    return state;
  }

  @override
  AppState afterAction(ActionType action, AppState state) {
    if (action is AddTodo) {
      _todosRepository.saveTodos(state.todos.toList());
    }

    if (action is ClearCompleted) {
      _todosRepository.saveTodos(state.todos.toList());
    }

    if (action is DeleteTodo) {
      _todosRepository.saveTodos(state.todos.toList());
    }

    if (action is ToggleAllComplete) {
      _todosRepository.saveTodos(state.todos.toList());
    }

    if (action is UpdateTodo) {
      _todosRepository.saveTodos(state.todos.toList());
    }

    return state;
  }
}
