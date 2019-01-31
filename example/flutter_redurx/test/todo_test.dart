import 'package:built_value/serializer.dart';
import 'package:test/test.dart';

import '../lib/models/todo.dart';

void main() {
  group('Todo', () {
    test('should have a serializer', () {
      expect(Todo.serializer, TypeMatcher<Serializer<Todo>>());
    });
  });
}
