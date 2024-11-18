import 'package:firebase_crashlytics/firebase_crashlytics.dart';

abstract class FirebaseCrashlyticsLogger {
  void log(String message);
  void error(dynamic e, StackTrace? stack, {dynamic reason});
}

class FirebaseCrashlyticsLoggerImpl implements FirebaseCrashlyticsLogger {
  @override
  void log(String message) {
    FirebaseCrashlytics.instance.log(message);
  }

  @override
  void error(dynamic e, StackTrace? stack, {dynamic reason}) {
    FirebaseCrashlytics.instance.recordError(e, stack, reason: reason);
  }
}
