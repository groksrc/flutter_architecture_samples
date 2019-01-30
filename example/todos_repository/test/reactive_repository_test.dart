// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todos_repository_base/todos_repository_base.dart';
import 'package:todos_repository/todos_repository.dart';

class MockTodosStorage extends Mock implements TodosStorageBase {}

main() {
  group('ReactiveTodosRepository', () {
    List<TodoEntity> createTodos([String task = "Task"]) {
      return [
        TodoEntity(task, "1", "Hallo", false),
        TodoEntity(task, "2", "Friend", false),
        TodoEntity(task, "3", "Yo", false),
      ];
    }

    test('should load todos from the base repo and send them to the client',
        () {
      final todos = createTodos();
      final storage = MockTodosStorage();
      final reactiveRepository = TodosRepository(
        storage: storage,
        seedValue: todos,
      );

      when(storage.loadTodos())
          .thenAnswer((_) => Future.value(<TodoEntity>[]));

      expect(reactiveRepository.todos(), emits(todos));
    });

    test('should only load from the base repo once', () {
      final todos = createTodos();
      final storage = MockTodosStorage();
      final reactiveRepository = TodosRepository(
        storage: storage,
        seedValue: todos,
      );

      when(storage.loadTodos()).thenAnswer((_) => Future.value(todos));

      expect(reactiveRepository.todos(), emits(todos));
      expect(reactiveRepository.todos(), emits(todos));

      verify(storage.loadTodos()).called(1);
    });

    test('should add todos to the storage and emit the change', () async {
      final todos = createTodos();
      final storage = MockTodosStorage();
      final reactiveRepository = TodosRepository(
        storage: storage,
        seedValue: [],
      );

      when(storage.loadTodos())
          .thenAnswer((_) => new Future.value(<TodoEntity>[]));
      when(storage.saveTodos(todos)).thenAnswer((_) => Future.value());

      await reactiveRepository.addNewTodo(todos.first);

      verify(storage.saveTodos(any));
      expect(reactiveRepository.todos(), emits([todos.first]));
    });

    test('should update a todo in the storage and emit the change',
        () async {
      final todos = createTodos();
      final storage = MockTodosStorage();
      final reactiveRepository = TodosRepository(
        storage: storage,
        seedValue: todos,
      );
      final update = createTodos("task");

      when(storage.loadTodos()).thenAnswer((_) => Future.value(todos));
      when(storage.saveTodos(any)).thenAnswer((_) => Future.value());

      await reactiveRepository.updateTodo(update.first);

      verify(storage.saveTodos(any));
      expect(
        reactiveRepository.todos(),
        emits([update[0], todos[1], todos[2]]),
      );
    });

    test('should remove todos from the repo and emit the change', () async {
      final storage = MockTodosStorage();
      final todos = createTodos();
      final reactiveRepository = TodosRepository(
        storage: storage,
        seedValue: todos,
      );
      final future = Future.value(todos);

      when(storage.loadTodos()).thenAnswer((_) => future);
      when(storage.saveTodos(any)).thenAnswer((_) => Future.value());

      await reactiveRepository.deleteTodo([todos.first.id, todos.last.id]);

      verify(storage.saveTodos(any));
      expect(reactiveRepository.todos(), emits([todos[1]]));
    });
  });
}
