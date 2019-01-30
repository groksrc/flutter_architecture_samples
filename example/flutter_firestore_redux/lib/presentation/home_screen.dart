// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import '../containers/active_tab.dart';
import '../containers/extra_actions_container.dart';
import '../containers/filter_selector.dart';
import '../containers/filtered_todos.dart';
import '../containers/stats.dart';
import '../containers/tab_selector.dart';
import '../localization.dart';
import '../models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(FirestoreReduxLocalizations.of(context).appTitle),
            actions: [
              FilterSelector(visible: activeTab == AppTab.todos),
              ExtraActionsContainer(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}
