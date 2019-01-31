// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

import '../controller.dart';
import '../screens/detail_screen.dart';
import '../widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  TodoList({Key key}) : super(key: key);

  static final _controller = Controller.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Controller.isLoading ? _buildLoading : _buildList(),
    );
  }

  Center get _buildLoading {
    return Center(
      child: CircularProgressIndicator(
        key: ArchSampleKeys.todosLoading,
      ),
    );
  }

  ListView _buildList() {
    final todos = Controller.filteredTodos;
    return ListView.builder(
      key: ArchSampleKeys.todoList,
      itemCount: todos.length,
      itemBuilder: (BuildContext context, int index) {
        final Map todo = todos.elementAt(index).cast<String, Object>();
        return TodoItem(
          todo: todo,
          onDismissed: (direction) {
            _removeTodo(context, todo);
          },
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) {
                  return DetailScreen(
                    todoId: todo['id'],
                  );
                },
              ),
            ).then((todo) {
              if (todo is Map && todo.isNotEmpty) {
                _showUndoSnackbar(context, todo);
              }
            });
          },
          onCheckboxChanged: (complete) {
            _controller.checked(todo);
          },
        );
      },
    );
  }

  void _removeTodo(BuildContext context, Map todo) {
    _controller.remove(todo);
    _showUndoSnackbar(context, todo);
  }

  void _showUndoSnackbar(BuildContext context, Map todo) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        key: ArchSampleKeys.snackbar,
        duration: Duration(seconds: 2),
        backgroundColor: Theme.of(context).backgroundColor,
        content: Text(
          ArchSampleLocalizations.of(context).todoDeleted(todo['task']),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          key: ArchSampleKeys.snackbarAction(todo['id']),
          label: ArchSampleLocalizations.of(context).undo,
          onPressed: () {
            _controller.undo(todo);
          },
        ),
      ),
    );
  }
}
