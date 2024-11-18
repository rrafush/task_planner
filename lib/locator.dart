import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_to_do_app/shared/utils/adapters/firebase_crashlytics_logger.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/create_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/delete_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/update_task_usecase.dart';
import 'package:simple_to_do_app/shared/utils/adapters/shared_preferences_adapter.dart';
import 'package:simple_to_do_app/shared/utils/adapters/uuid_adapter.dart';

final locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerLazySingleton<SharedPreferencesAdapter>(
    () => SharedPreferencesAdapterImpl(),
  );
  locator.registerLazySingleton<UuidAdapter>(
    () => UuidAdapterImpl(),
  );
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(),
  );
  locator.registerLazySingleton<CreateTaskUsecase>(
    () => CreateTaskUsecaseImpl(
      locator<Repository>(),
    ),
  );
  locator.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteTaskUsecaseImpl(
      locator<Repository>(),
    ),
  );
  locator.registerLazySingleton<GetTasksUsecase>(
    () => GetTasksUsecaseImpl(
      locator<Repository>(),
    ),
  );
  locator.registerLazySingleton<UpdateTaskUsecase>(
    () => UpdateTaskUsecaseImpl(
      locator<Repository>(),
    ),
  );
  locator.registerLazySingleton<FirebaseCrashlyticsLogger>(
    () => FirebaseCrashlyticsLoggerImpl(),
  );
  locator.registerLazySingleton<NotificationService>(
    () => NotificationServiceImpl(
      flutterLocalNotificationsPlugin: FlutterLocalNotificationsPlugin(),
    ),
  );
}
