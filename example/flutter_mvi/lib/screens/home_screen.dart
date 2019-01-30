// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:mvi_base/mvi_base.dart';

import '../dependency_injection.dart';
import '../localization.dart';
import '../widgets/extra_actions_button.dart';
import '../widgets/filter_button.dart';
import '../widgets/loading.dart';
import '../widgets/stats_counter.dart';
import '../widgets/todo_list.dart';

enum AppTab { todos, stats }

class HomeScreen extends StatefulWidget {
  final MviPresenter<TodosListModel> Function(TodosListView) initPresenter;

  HomeScreen({Key key, this.initPresenter})
      : super(key: key ?? ArchSampleKeys.homeScreen);

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> with TodosListView {
  AppTab activeTab = AppTab.todos;
  TodosListPresenter presenter;

  @override
  void didChangeDependencies() {
    presenter = widget.initPresenter != null
        ? widget.initPresenter(this)
        : TodosListPresenter(
            view: this,
            todosInteractor: Injector.of(context).todosInteractor,
            userInteractor: Injector.of(context).userInteractor,
          );

    presenter.setUp();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    tearDown();
    presenter.tearDown();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodosListModel>(
      stream: presenter,
      initialData: presenter.latest,
      builder: (context, modelSnapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(BlocLocalizations.of(context).appTitle),
            actions: [
              FilterButton(
                isActive: activeTab == AppTab.todos,
                activeFilter:
                    modelSnapshot.data?.activeFilter ?? VisibilityFilter.all,
                onSelected: updateFilter.add,
              ),
              ExtraActionsButton(
                allComplete: modelSnapshot.data?.allComplete ?? false,
                hasCompletedTodos:
                    modelSnapshot.data?.hasCompletedTodos ?? false,
                onSelected: (action) {
                  if (action == ExtraAction.toggleAllComplete) {
                    toggleAll.add(null);
                  } else if (action == ExtraAction.clearCompleted) {
                    clearCompleted.add(null);
                  }
                },
              ),
            ],
          ),
          body: modelSnapshot.data.loading
              ? LoadingSpinner(
                  key: ArchSampleKeys.todosLoading,
                )
              : activeTab == AppTab.todos
                  ? TodoList(
                      loading: modelSnapshot.data.loading,
                      addTodo: addTodo.add,
                      updateTodo: updateTodo.add,
                      deleteTodo: deleteTodo.add,
                      todos: modelSnapshot.data?.visibleTodos ?? [],
                    )
                  : StatsCounter(),
          floatingActionButton: FloatingActionButton(
            key: ArchSampleKeys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: ArchSampleLocalizations.of(context).addTodo,
          ),
          bottomNavigationBar: BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: AppTab.values.indexOf(activeTab),
            onTap: (index) {
              setState(() {
                activeTab = AppTab.values[index];
              });
            },
            items: AppTab.values.map((tab) {
              return BottomNavigationBarItem(
                icon: Icon(
                  tab == AppTab.todos ? Icons.list : Icons.show_chart,
                  key: tab == AppTab.stats
                      ? ArchSampleKeys.statsTab
                      : ArchSampleKeys.todoTab,
                ),
                title: Text(
                  tab == AppTab.stats
                      ? ArchSampleLocalizations.of(context).stats
                      : ArchSampleLocalizations.of(context).todos,
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
