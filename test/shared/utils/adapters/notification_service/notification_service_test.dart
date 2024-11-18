import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_to_do_app/shared/utils/adapters/notification_service/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class FlutterLocalNotificationsPluginMock extends Mock
    implements FlutterLocalNotificationsPlugin {}

class TZDateTimeMock extends Mock implements tz.TZDateTime {}

void main() {
  late final FlutterLocalNotificationsPlugin
      flutterLocalNotificationsPluginMock;
  setUpAll(() {
    tz.initializeTimeZones();
    flutterLocalNotificationsPluginMock = FlutterLocalNotificationsPluginMock();

    registerFallbackValue(InitializationSettings());
    registerFallbackValue(TZDateTimeMock());
    registerFallbackValue(NotificationDetails());
    registerFallbackValue(UILocalNotificationDateInterpretation.absoluteTime);
    registerFallbackValue(AndroidScheduleMode.exact);

    when(
      () => flutterLocalNotificationsPluginMock.initialize(
        any(),
        onDidReceiveNotificationResponse:
            any(named: 'onDidReceiveNotificationResponse'),
        onDidReceiveBackgroundNotificationResponse:
            any(named: 'onDidReceiveBackgroundNotificationResponse'),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      () => flutterLocalNotificationsPluginMock.show(
        any(),
        any(),
        any(),
        any(),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      () => flutterLocalNotificationsPluginMock.zonedSchedule(
        any(),
        any(),
        any(),
        any(),
        any(),
        uiLocalNotificationDateInterpretation:
            any(named: 'uiLocalNotificationDateInterpretation'),
        androidScheduleMode: any(named: 'androidScheduleMode'),
      ),
    ).thenAnswer(
      (_) => Future.value(),
    );

    when(
      () => flutterLocalNotificationsPluginMock.cancel(any()),
    ).thenAnswer(
      (_) => Future.value(),
    );
  });

  test('Should initialize plugin properly', () async {
    final notificationService = NotificationServiceImpl(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPluginMock,
    );

    await notificationService.init();

    verify(
      () => flutterLocalNotificationsPluginMock.initialize(
        any(),
        onDidReceiveNotificationResponse:
            any(named: 'onDidReceiveNotificationResponse'),
        onDidReceiveBackgroundNotificationResponse:
            any(named: 'onDidReceiveBackgroundNotificationResponse'),
      ),
    ).called(1);
  });

  test('Should show notification properly', () async {
    final notificationService = NotificationServiceImpl(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPluginMock,
    );

    await notificationService.showNotification(
      title: 'title',
      body: 'body',
    );

    verify(
      () => flutterLocalNotificationsPluginMock.show(
        any(),
        'title',
        'body',
        any(),
      ),
    ).called(1);
  });

  test('Should schedule notification properly', () async {
    final notificationService = NotificationServiceImpl(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPluginMock,
    );

    await notificationService.shceduleNotification(
      title: 'title',
      body: 'body',
      time: DateTime(2024),
      id: 1,
    );

    verify(
      () => flutterLocalNotificationsPluginMock.zonedSchedule(
        1,
        'title',
        'body',
        any(),
        any(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact,
      ),
    ).called(1);
  });

  test('Should cancel notification properly', () async {
    final notificationService = NotificationServiceImpl(
      flutterLocalNotificationsPlugin: flutterLocalNotificationsPluginMock,
    );

    await notificationService.cancelNotification(id: 1);

    verify(
      () => flutterLocalNotificationsPluginMock.cancel(1),
    ).called(1);
  });
}
