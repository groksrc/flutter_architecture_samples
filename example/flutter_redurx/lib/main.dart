library redurx_sample;

import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:flutter_redurx/flutter_redurx.dart';

import 'actions/fetch_todos.dart';
import 'data/todos_repository.dart';
import 'localizations.dart';
import 'middlewares/todos_middleware.dart';
import 'models/app_state.dart';
import 'screens/add_edit_screen.dart';
import 'screens/home_screen.dart';

void main() {
  final initialState = AppState.loading();
  final store = Store<AppState>(initialState);

  store.add(TodosMiddleware(TodosRepository()));
  store.dispatch(FetchTodos());

  runApp(Provider(store: store, child: ReduRxApp()));
}

class ReduRxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ReduRxLocalizations().appTitle,
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        ArchSampleLocalizationsDelegate(),
        ReduRxLocalizationsDelegate(),
      ],
      routes: {
        ArchSampleRoutes.home: (context) {
          return HomeScreen();
        },
        ArchSampleRoutes.addTodo: (context) {
          return AddEditScreen(isEditing: false);
        },
      },
    );
  }
}
