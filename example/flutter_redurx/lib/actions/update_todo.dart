import 'package:flutter_redurx/flutter_redurx.dart';

import '../models/app_state.dart';
import '../models/todo.dart';

class UpdateTodo implements Action<AppState> {
  final String id;
  final Todo updatedTodo;

  UpdateTodo(this.id, this.updatedTodo);

  @override
  AppState reduce(AppState state) {
    final todos = state.todos
        .rebuild((b) => b..map((todo) => todo.id == id ? updatedTodo : todo));

    return state.rebuild((b) => b..todos = todos.toBuilder());
  }
}
