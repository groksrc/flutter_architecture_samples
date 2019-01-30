// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:core';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:todos_repository_base/todos_repository_base.dart';

/// A class that glues together our local file storage and web client. It has a
/// clear responsibility: Load Todos and Persist todos.

class TodosRepository implements TodosRepositoryBase {
  final TodosStorageBase _storage;
  final BehaviorSubject<List<TodoEntity>> _todosSubject;
  bool _loaded = false;

  TodosRepository({
    @required TodosStorageBase storage,
    List<TodoEntity> seedValue,
  })  : this._storage = storage,
        this._todosSubject = BehaviorSubject<List<TodoEntity>>(seedValue: seedValue);

  @override
  Future<void> addNewTodo(TodoEntity todo) async {
    _todosSubject.add(List.unmodifiable([]
      ..addAll(_todosSubject.value ?? [])
      ..add(todo)));

    await _storage.saveTodos(_todosSubject.value);
  }

  @override
  Future<void> deleteTodo(List<String> idList) async {
    _todosSubject.add(
      List<TodoEntity>.unmodifiable(_todosSubject.value.fold<List<TodoEntity>>(
        <TodoEntity>[],
        (prev, entity) {
          return idList.contains(entity.id) ? prev : (prev..add(entity));
        },
      )),
    );

    await _storage.saveTodos(_todosSubject.value);
  }

  @override
  Stream<List<TodoEntity>> todos() {
    if (!_loaded) _loadTodos();

    return _todosSubject.stream;
  }

  void _loadTodos() {
    _loaded = true;

    _storage.loadTodos().then((entities) {
      _todosSubject.add(List<TodoEntity>.unmodifiable(
        []..addAll(_todosSubject.value ?? [])..addAll(entities),
      ));
    });
  }

  @override
  Future<void> updateTodo(TodoEntity update) async {
    _todosSubject.add(
      List<TodoEntity>.unmodifiable(_todosSubject.value.fold<List<TodoEntity>>(
        <TodoEntity>[],
        (prev, entity) => prev..add(entity.id == update.id ? update : entity),
      )),
    );

    await _storage.saveTodos(_todosSubject.value);
  }
}
