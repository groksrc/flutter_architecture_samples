// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:bloc_flutter_sample/main.dart' as app;
import 'package:blocs/blocs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_todos_repository/firebase_todos_repository.dart';
import 'package:firebase_todos_repository/firebase_user_repository.dart';

void main() {
  app.main(
    todosInteractor: TodosInteractor(
      FirebaseTodosRepository(Firestore.instance),
    ),
    userRepository: FirebaseUserRepository(FirebaseAuth.instance),
  );
}
