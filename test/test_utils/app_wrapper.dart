import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';

import '../task_list/presentation/bloc/task_bloc_mock.dart' as task_bloc_mock;

class AppWrapper {
  static void registerFallbackValues() {
    task_bloc_mock.registerFallbackValues();
  }

  static Widget wrap({
    required Widget child,
    TaskBloc? taskBloc,
  }) {
    return BlocProvider(
      create: (context) => taskBloc ?? task_bloc_mock.TaskBlocMock(),
      child: MaterialApp(
        localizationsDelegates: [
          ...AppLocalizations.localizationsDelegates,
        ],
        home: child,
      ),
    );
  }
}
