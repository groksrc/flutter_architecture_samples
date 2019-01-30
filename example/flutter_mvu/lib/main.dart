import 'package:flutter/material.dart';
import 'package:flutter_architecture_samples/flutter_architecture_samples.dart';

import 'localization.dart';
import 'common/repository_commands.dart' show repoCmds;
import 'common/router.dart' as router;
import 'home/home.dart' as home;
import 'home/types.dart';
import 'edit/edit.dart' as edit;

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ArchSampleTheme.theme,
      localizationsDelegates: [
        new ArchSampleLocalizationsDelegate(),
        new MvuLocalizationsDelegate()
      ],
      home: new Builder(
        builder: (c) {
          router.init(c);
          return home.createProgram(AppTab.todos).build();
        },
      ),
      routes: {
        ArchSampleRoutes.addTodo: (_) =>
            edit.createProgram(repoCmds).build()
      },
    );
  }
}
