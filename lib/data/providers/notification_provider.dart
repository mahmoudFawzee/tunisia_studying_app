// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationProvider {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotification = BehaviorSubject<String?>();
  static const _dailyNotificationChanelId = '1';
  static const _oneTimeNotificationChanelId = '0';
  static Future<void> setup({
    required bool isScheduled,
  }) async {
    const androidInitializationSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInitializationSetting,
      iOS: iosInitializationSetting,
    );
    final details = await _notification.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotification.add(details.notificationResponse!.payload);
    }
    await _notification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        onNotification.add(details.payload);
      },
    );
    if (isScheduled) {
      tz.initializeTimeZones();
      final location = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(location));
    }
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        '0',
        'general',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future showNotification({
    required MyNotification notification,
    required bool scheduleDaily,
    String? payload,
  }) async {
    int notificationId =await NotificationProvider.getNumberOfNotifications();
    _notification.zonedSchedule(
      notificationId,
      null,
      notification.name,
      //scheduledDate,
      scheduleDaily
          ? NotificationProvider._scheduleDaily(const Time(20))
          : tz.TZDateTime.from(notification.dateTime, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static tz.TZDateTime _scheduleDaily(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }

  static void cancel({
    required int id,
  }) =>
      _notification.cancel(id);
  static void cancelAll() => _notification.cancelAll();
  static Future<int> getNumberOfNotifications() async {
    List<ActiveNotification> pastNotifications =
        await _notification.getActiveNotifications();
    List<PendingNotificationRequest> comingNotifications =
        await _notification.pendingNotificationRequests();
    return comingNotifications.length + pastNotifications.length;
  }

  static Future<List<ActiveNotification>> getShownNotifications() async {
    List<ActiveNotification> pastNotifications =
        await _notification.getActiveNotifications();
    return pastNotifications;
  }
}

class MyNotification {
  final String name;
  final DateTime dateTime;
  const MyNotification({
    required this.name,
    required this.dateTime,
  });
}
