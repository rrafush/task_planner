import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/shared/utils/adapters/firebase_crashlytics_logger.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:simple_to_do_app/shared/utils/adapters/uuid_adapter.dart';
import 'package:simple_to_do_app/task_list.dart/data/repository.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/create_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/delete_task_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/get_tasks_usecase.dart';
import 'package:simple_to_do_app/task_list.dart/domain/usecases/update_task_usecase.dart';
import 'package:simple_to_do_app/shared/utils/adapters/shared_preferences_adapter.dart';

class SharedPreferencesAdapterMock extends Mock
    implements SharedPreferencesAdapter {}

class RepositoryMock extends Mock implements Repository {}

class CreateToDoUsecaseMock extends Mock implements CreateTaskUsecase {}

class DeleteToDoUsecaseMock extends Mock implements DeleteTaskUsecase {}

class GetToDosUsecaseMock extends Mock implements GetTasksUsecase {}

class UpdateToDoUsecaseMock extends Mock implements UpdateTaskUsecase {}

class FirebaseCrashlyticsLoggerMock extends Mock
    implements FirebaseCrashlyticsLogger {}

class UuidAdapterMock extends Mock implements UuidAdapter {}

class NotificationServiceMock extends Mock implements NotificationService {}

GetIt locator = GetIt.instance;
void setupLocatorMock() {
  locator.registerLazySingleton<SharedPreferencesAdapter>(
    () => SharedPreferencesAdapterMock(),
  );
  locator.registerLazySingleton<Repository>(
    () => RepositoryMock(),
  );
  locator.registerLazySingleton<CreateTaskUsecase>(
    () => CreateToDoUsecaseMock(),
  );
  locator.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteToDoUsecaseMock(),
  );
  locator.registerLazySingleton<GetTasksUsecase>(
    () => GetToDosUsecaseMock(),
  );
  locator.registerLazySingleton<UpdateTaskUsecase>(
    () => UpdateToDoUsecaseMock(),
  );
  locator.registerLazySingleton<FirebaseCrashlyticsLogger>(
    () => FirebaseCrashlyticsLoggerMock(),
  );

  locator.registerLazySingleton<UuidAdapter>(
    () => UuidAdapterMock(),
  );
  locator.registerLazySingleton<NotificationService>(
    () => NotificationServiceMock(),
  );
}
