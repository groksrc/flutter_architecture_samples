// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:meta/meta.dart';
import 'package:flutter_mvi_base/mvi_base.dart';

import 'dependency_injection.dart';
import 'localization.dart';
import 'screens/add_edit_screen.dart';
import 'screens/home_screen.dart';

void main({
  @required TodosInteractor todosRepository,
  @required UserInteractor userInteractor,
}) {
  runApp(Injector(
    todosInteractor: todosRepository,
    userInteractor: userInteractor,
    child: MaterialApp(
      title: BlocLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        InheritedWidgetLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return HomeScreen();
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(
            addTodo: Injector.of(context).todosInteractor.addNewTodo,
          );
        },
      },
    ),
  ));
}
