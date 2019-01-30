library edit;

import 'package:dartea/dartea.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:todos_repository_base/todos_repository_base.dart';

import '../edit/types.dart';
import '../common/repository_commands.dart' show CmdRepository;
import '../common/router.dart' as router;

part 'state.dart';
part 'view.dart';

Program<EditTodoModel, EditTodoMessage, dynamic> createProgram(
        CmdRepository repo,
        {TodoEntity todo}) =>
    Program(() => init(todo), (msg, model) => update(repo, msg, model), view);
