// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import '../actions/actions.dart';
import '../models/models.dart';
import '../presentation/add_edit_screen.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:flutter_built_redux/flutter_built_redux.dart';

class EditTodo extends StoreConnector<AppState, AppActions, Null> {
  final Todo todo;

  EditTodo({this.todo, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, _, AppActions actions) {
    return AddEditScreen(
      key: ArchSampleKeys.editTodoScreen,
      isEditing: true,
      onSave: (task, note) {
        actions.updateTodoAction(UpdateTodoActionPayload(
            todo.id,
            todo.rebuild((b) => b
              ..task = task
              ..note = note)));
      },
      todo: todo,
    );
  }

  @override
  connect(AppState state) {}
}
