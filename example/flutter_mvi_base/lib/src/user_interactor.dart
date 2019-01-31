// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';

import 'package:todos_repository_base/todos_repository_base.dart';

import 'models/user.dart';

class UserInteractor {
  final UserRepositoryBase _repository;

  UserInteractor(UserRepositoryBase repository) : _repository = repository;

  Future<User> login() async => User((await _repository.login()).displayName);
}
