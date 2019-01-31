// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository_firebase/todos_repository_firebase.dart';
import 'package:flutter_mvi_base/flutter_mvi_base.dart';

import 'main.dart' as app;

void main() {
  app.main(
    todosRepository: TodosInteractor(
      FirebaseTodosRepository(Firestore.instance),
    ),
    userInteractor: UserInteractor(
      FirebaseUserRepository(FirebaseAuth.instance),
    ),
  );
}
