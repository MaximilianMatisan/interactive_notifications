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
