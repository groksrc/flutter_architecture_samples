// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todos_repository_firebase/todos_repository_firebase.dart';
import 'package:simple_bloc_flutter_sample/main.dart' as app;
import 'package:simple_blocs/simple_blocs.dart';

void main() {
  app.main(
    todosInteractor: TodosInteractor(
      FirebaseTodosRepository(Firestore.instance),
    ),
    userRepository: FirebaseUserRepository(FirebaseAuth.instance),
  );
}
