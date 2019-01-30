// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter_blocs/dependency_injection.dart';
import 'package:flutter_blocs/localization.dart';
import 'package:flutter_blocs/screens/add_edit_screen.dart';
import 'package:flutter_blocs/screens/home_screen.dart';
import 'package:flutter_blocs/widgets/todos_bloc_provider.dart';
import 'package:blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:meta/meta.dart';
import 'package:todos_repository_base/todos_repository_base.dart';

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
              addTodo: TodosBlocProvider.of(context).addTodo.add,
            );
          },
        },
      ),
    ),
  ));
}
