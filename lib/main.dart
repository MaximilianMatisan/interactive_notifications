import 'package:flutter/material.dart';
import 'package:interactive_notifications/pages/home_page.dart';
import 'package:interactive_notifications/util/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          dynamicSchemeVariant: DynamicSchemeVariant.tonalSpot
        )
      ),
      home: const MyHomePage(),
    );
  }
}

