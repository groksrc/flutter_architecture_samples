// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_blocs/main.dart' as app;
import 'package:flutter_blocs_base/flutter_blocs_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository_firebase/todos_repository_firebase.dart';

void main() {
  app.main(
    todosInteractor: TodosInteractor(
      FirebaseTodosRepository(Firestore.instance),
    ),
    userRepository: FirebaseUserRepository(FirebaseAuth.instance),
  );
}
