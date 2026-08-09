import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const DarwinInitializationSettings iOSSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestSoundPermission: true,
    requestBadgePermission: true,
    defaultPresentAlert: true,
    defaultPresentSound: true,
    defaultPresentBadge: true,
  );
  //TODO take a look at permissions for android
  const InitializationSettings initSettings = InitializationSettings(
    iOS: iOSSettings,
  );

  await _flutterLocalNotificationsPlugin.initialize(settings: initSettings);
}

Future<void> triggerSelfAssessmentNotification() async {
  const notificationDetails = NotificationDetails(
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
    ),
  );
  await _flutterLocalNotificationsPlugin.show(
    id: 0,
    title: 'Rate your recent study session!',
    body: 'How productive were you?',
    notificationDetails: notificationDetails,
  );
}
