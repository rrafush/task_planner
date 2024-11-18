import 'dart:async';

import 'package:timezone/data/latest.dart' as tz;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simple_to_do_app/firebase_options.dart';
import 'package:simple_to_do_app/locator.dart';
import 'package:simple_to_do_app/navigation/router.dart';
import 'package:simple_to_do_app/shared/theme/app_theme.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/bloc/task_bloc.dart';
import 'package:simple_to_do_app/task_list.dart/presentation/task_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = (err) {
    FirebaseCrashlytics.instance.recordFlutterError(err);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };

  await setupLocator();

  tz.initializeTimeZones();
  locator<NotificationService>().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TaskBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: defineTheme(),
        home: const TaskListScreen(),
        localizationsDelegates: const [
          ...AppLocalizations.localizationsDelegates,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('pt'),
        ],
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) => generateRoute(settings),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
