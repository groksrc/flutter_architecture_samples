import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';

import 'repository_commands.dart';
import 'todo_model.dart';
import '../details/details.dart' as details;
import '../edit/edit.dart' as edit;

NavigatorState _navigator;

void init(BuildContext context) {
  _navigator = Navigator.of(context);
}

Cmd<T> goToDetailsScreen<T>(TodoModel todo) =>
    Cmd.ofAction<T>(() => _navigator.push(new MaterialPageRoute(
        builder: (_) => details.createProgram(repoCmds, todo).build())));

Cmd<T> goToEditTodoScreen<T>(TodoModel todo) =>
    Cmd.ofAction<T>(() => _navigator.push(new MaterialPageRoute(
        builder: (_) =>
            edit.createProgram(repoCmds, todo: todo.toEntity()).build())));

Cmd<T> goToCreateNewScreen<T>() =>
    Cmd.ofAction<T>(() => _navigator.push(new MaterialPageRoute(
        builder: (_) => edit.createProgram(repoCmds).build())));

Cmd<T> goBack<T>() => Cmd.ofAction<T>(() => _navigator.pop());
