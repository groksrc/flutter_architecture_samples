library todos;

import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';
import 'package:dartea/dartea.dart';

import '../common/extra_actions_menu.dart' as menu;
import '../common/repository_commands.dart' show CmdRepository;
import '../common/router.dart' as router;
import '../common/snackbar.dart' as snackbar;
import '../common/todo_model.dart';
import '../home/types.dart';
import '../todos/types.dart';

part 'state.dart';
part 'view.dart';