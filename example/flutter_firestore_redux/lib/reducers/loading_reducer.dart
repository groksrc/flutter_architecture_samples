// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';

import '../actions/actions.dart';

final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadTodosAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
