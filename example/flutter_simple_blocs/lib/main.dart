// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:meta/meta.dart';
import 'package:flutter_simple_blocs_base/flutter_simple_blocs_base.dart';
import 'package:todos_repository_base/todos_repository_base.dart';

import 'dependency_injection.dart';
import 'localization.dart';
import 'screens/add_edit_screen.dart';
import 'screens/home_screen.dart';
import 'widgets/todos_bloc_provider.dart';

void main({
  @required TodosInteractor todosInteractor,
  @required UserRepositoryBase userRepository,
}) {
  runApp(Injector(
    todosInteractor: todosInteractor,
    userRepository: userRepository,
    child: TodosBlocProvider(
      bloc: TodosListBloc(todosInteractor),
      child: MaterialApp(
        title: BlocLocalizations().appTitle,
        theme: ArchSampleTheme.theme,
        localizationsDelegates: [
          ArchSampleLocalizationsDelegate(),
          InheritedWidgetLocalizationsDelegate(),
        ],
        routes: {
          ArchSampleRoutes.home: (context) {
            return HomeScreen(
              repository: Injector.of(context).userRepository,
            );
          },
          ArchSampleRoutes.addTodo: (context) {
            return AddEditScreen(
              addTodo: TodosBlocProvider.of(context).addTodo,
            );
          },
        },
      ),
    ),
  ));
}
