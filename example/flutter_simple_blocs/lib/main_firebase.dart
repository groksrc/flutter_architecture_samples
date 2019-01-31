// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository_firebase/todos_repository_firebase.dart';
import 'package:flutter_simple_blocs_base/flutter_simple_blocs_base.dart';

import 'main.dart' as app;

void main() {
  app.main(
    todosInteractor: TodosInteractor(
      FirebaseTodosRepository(Firestore.instance),
    ),
    userRepository: FirebaseUserRepository(FirebaseAuth.instance),
  );
}
