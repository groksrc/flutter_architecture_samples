// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

import '../containers/action_selector.dart';
import '../containers/active_tab.dart';
import '../containers/filter_selector.dart';
import '../containers/filtered_todos.dart';
import '../containers/stats.dart';
import '../containers/tab_selector.dart';
import '../localization.dart';
import '../models/models.dart';
import '../presentation/filter_button.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BuiltReduxLocalizations.of(context).appTitle),
            actions: [
              FilterSelector(
                builder: (context, vm) {
                  return FilterButton(
                    visible: activeTab == AppTab.todos,
                    activeFilter: vm.activeFilter,
                    onSelected: vm.onFilterSelected,
                  );
                },
              ),
              ExtraActionSelector()
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
