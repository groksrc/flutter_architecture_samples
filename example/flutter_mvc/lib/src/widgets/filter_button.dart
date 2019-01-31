// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

import '../controller.dart';
import '../todo_list_model.dart';

class FilterButton extends StatelessWidget {

  final bool isActive;

  FilterButton({this.isActive, Key key}) : super(key: key);

  final con = Controller.instance;

  @override
  Widget build(BuildContext context) {
//    var model = TodoListModel.of(context, rebuildOnChange: true);
    return AnimatedOpacity(
      opacity: isActive ? 1.0 : 0.0,
      duration: Duration(milliseconds: 150),
      child: PopupMenuButton<VisibilityFilter>(
        key: ArchSampleKeys.filterButton,
        tooltip: ArchSampleLocalizations.of(context).filterTodos,
        onSelected: (filter) {
          Controller.activeFilter = filter;
          con.refresh();
        },
        itemBuilder: (BuildContext context) => _items(context),
        icon: Icon(Icons.filter_list),
      ),
    );
  }

  List<PopupMenuItem<VisibilityFilter>> _items(BuildContext context) {
    final activeStyle = Theme.of(context)
        .textTheme
        .body1
        .copyWith(color: Theme.of(context).accentColor);
    final defaultStyle = Theme.of(context).textTheme.body1;

    return [
      PopupMenuItem<VisibilityFilter>(
        key: ArchSampleKeys.allFilter,
        value: VisibilityFilter.all,
        child: Text(
          ArchSampleLocalizations.of(context).showAll,
          style: Controller.activeFilter == VisibilityFilter.all
              ? activeStyle
              : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        key: ArchSampleKeys.activeFilter,
        value: VisibilityFilter.active,
        child: Text(
          ArchSampleLocalizations.of(context).showActive,
          style: Controller.activeFilter == VisibilityFilter.active
              ? activeStyle
              : defaultStyle,
        ),
      ),
      PopupMenuItem<VisibilityFilter>(
        key: ArchSampleKeys.completedFilter,
        value: VisibilityFilter.completed,
        child: Text(
          ArchSampleLocalizations.of(context).showCompleted,
          style: Controller.activeFilter == VisibilityFilter.completed
              ? activeStyle
              : defaultStyle,
        ),
      ),
    ];
  }
}
