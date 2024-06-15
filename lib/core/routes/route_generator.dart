import 'package:finnhub_project/core/routes/routes.dart';
import 'package:finnhub_project/presentation/pages/home_page.dart';
import 'package:finnhub_project/presentation/pages/list_stocks_page.dart';
import 'package:flutter/material.dart';

import '../../presentation/pages/login_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );

      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case Routes.listStock:
        return MaterialPageRoute(
          builder: (context) => const ListStockPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}
