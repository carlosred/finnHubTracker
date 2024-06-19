import 'package:finnhub_project/core/routes/routes.dart';
import 'package:finnhub_project/firebase_options.dart';
import 'package:finnhub_project/services/local_notifications_service.dart';
import 'package:finnhub_project/utils/styles.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/routes/route_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  LocalNotificationService().initNotification();
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinnHubTracker',
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
      initialRoute: Routes.loginRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
