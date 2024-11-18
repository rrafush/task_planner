import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationService {
  Future<void> init();
  Future<void> showNotification({
    required String title,
    required String body,
  });
  Future<void> shceduleNotification({
    required String title,
    required String body,
    required DateTime time,
    required int id,
  });
  Future<void> cancelNotification({
    required int id,
  });
}

class NotificationServiceImpl implements NotificationService {
  const NotificationServiceImpl({
    required this.flutterLocalNotificationsPlugin,
  });
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static Future<void> onDidReceiveNotification(
      NotificationResponse response) async {
    //TODO: implement navigation to event page
  }

  @override
  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iOsinitializationSettings =
        DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: iOsinitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotification,
      onDidReceiveBackgroundNotificationResponse: onDidReceiveNotification,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
  }) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id',
        'channel_Name',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
    );
  }

  @override
  Future<void> shceduleNotification({
    required String title,
    required String body,
    required DateTime time,
    required int id,
  }) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'channel_Id',
        'channel_Name',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.exact,
    );
  }

  @override
  Future<void> cancelNotification({
    required int id,
  }) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
