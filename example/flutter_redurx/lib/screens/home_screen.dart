import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:tuple/tuple.dart';

import '../actions/clear_completed.dart';
import '../actions/toggle_all_complete.dart';
import '../actions/update_filter.dart';
import '../actions/update_tab.dart';
import '../localizations.dart';
import '../models/app_state.dart';
import '../models/app_tab.dart';
import '../models/extra_actions.dart';
import '../models/visibility_filter.dart';
import '../widgets/extra_actions_button.dart';
import '../widgets/filter_button.dart';
import '../widgets/stats_counter.dart';
import '../widgets/todo_list.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() : super(key: ArchSampleKeys.homeScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ReduRxLocalizations.of(context).appTitle),
        actions: [
          Connect<AppState, Tuple2<AppTab, VisibilityFilter>>(
            convert: (state) => Tuple2(state.activeTab, state.activeFilter),
            where: (prev, next) => next != prev,
            builder: (props) {
              return FilterButton(
                isActive: props.item1 == AppTab.todos,
                activeFilter: props.item2,
                onSelected: (filter) {
                  Provider.dispatch<AppState>(context, UpdateFilter(filter));
                },
              );
            },
          ),
          Connect<AppState, bool>(
            convert: (state) => state.allCompleteSelector,
            where: (prev, next) => next != prev,
            builder: (allComplete) {
              return ExtraActionsButton(
                allComplete: allComplete,
                onSelected: (action) {
                  if (action == ExtraAction.toggleAllComplete) {
                    Provider.dispatch<AppState>(context, ToggleAllComplete());
                  } else if (action == ExtraAction.clearCompleted) {
                    Provider.dispatch<AppState>(context, ClearCompleted());
                  }
                },
              );
            },
          ),
        ],
      ),
      body: Connect<AppState, AppTab>(
        convert: (state) => state.activeTab,
        where: (prev, next) => next != prev,
        builder: (activeTab) {
          return activeTab == AppTab.todos ? TodoList() : StatsCounter();
        },
      ),
      floatingActionButton: FloatingActionButton(
        key: ArchSampleKeys.addTodoFab,
        onPressed: () {
          Navigator.pushNamed(context, ArchSampleRoutes.addTodo);
        },
        child: Icon(Icons.add),
        tooltip: ArchSampleLocalizations.of(context).addTodo,
      ),
      bottomNavigationBar: Connect<AppState, AppTab>(
        convert: (state) => state.activeTab,
        where: (prev, next) => next != prev,
        builder: (activeTab) {
          return BottomNavigationBar(
            key: ArchSampleKeys.tabs,
            currentIndex: AppTab.toIndex(activeTab),
            onTap: (index) {
              Provider.dispatch<AppState>(
                  context, UpdateTab(AppTab.fromIndex(index)));
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
          );
        },
      ),
    );
  }
}
