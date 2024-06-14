import 'package:finnhub_project/presentation/pages/home_page.dart';
import 'package:finnhub_project/services/local_notifications_service.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  LocalNotificationService().initNotification();
  runApp(
    const ProviderScope(child: MyApp()),
  );
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
          background: Styles.backgroundColor,
          seedColor: Styles.mainAppColor,
        ),
        dropdownMenuTheme: const DropdownMenuThemeData(
          textStyle: TextStyle(
            color: Colors.white,
          ),
          menuStyle: MenuStyle(
            surfaceTintColor: MaterialStatePropertyAll(
              Colors.white,
            ),
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}