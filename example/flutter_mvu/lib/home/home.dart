library home;

import 'dart:async';

import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

import '../localization.dart';
import '../common/repository_commands.dart';
import '../common/router.dart' as router;
import '../common/snackbar.dart' as snackbar;
import '../home/types.dart';
import '../stats/stats.dart' as stats;
import '../stats/types.dart';
import '../todos/types.dart';
import '../todos/todos.dart' as todos;

part 'state.dart';
part 'view.dart';

Program<HomeModel, HomeMessage, StreamSubscription<RepositoryEvent>>
    createProgram(AppTab initTab) =>
        new Program(() => init(initTab), update, view,
            subscription: _repoSubscription);

StreamSubscription<RepositoryEvent> _repoSubscription(
    StreamSubscription<RepositoryEvent> currentSub,
    Dispatch<HomeMessage> dispatch,
    HomeModel model) {
  if (currentSub != null) {
    return currentSub;
  }
  final sub = repoCmds.events.listen((event) {
    if (event is RepoOnTodoAdded) {
      dispatch(OnNewTodoCreated(event.entity));
    }
    if (event is RepoOnTodoChanged) {
      dispatch(TodosMsg(OnTodoItemChanged(updated: event.entity)));
    }
    if (event is RepoOnTodoRemoved) {
      dispatch(TodosMsg(OnTodoItemChanged(removed: event.entity)));
    }
  });
  return sub;
}
