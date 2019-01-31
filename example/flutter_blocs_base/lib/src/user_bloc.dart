// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:todos_repository_base/todos_repository_base.dart';

class UserBloc {
  final UserRepositoryBase _repository;

  // Outputs
  Stream<UserEntity> login() =>
      _repository.login().asStream().asBroadcastStream();

  UserBloc(UserRepositoryBase repository) : this._repository = repository;
}
