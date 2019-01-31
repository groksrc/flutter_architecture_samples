// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import '../models/models.dart';
import '../reducers/loading_reducer.dart';
import '../reducers/tabs_reducer.dart';
import '../reducers/todos_reducer.dart';
import '../reducers/visibility_reducer.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    isLoading: loadingReducer(state.isLoading, action),
    todos: todosReducer(state.todos, action),
    activeFilter: visibilityReducer(state.activeFilter, action),
    activeTab: tabsReducer(state.activeTab, action),
  );
}
