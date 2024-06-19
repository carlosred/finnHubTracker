import 'package:animate_do/animate_do.dart';
import 'package:finnhub_project/core/routes/routes.dart';
import 'package:finnhub_project/presentation/pages/home_page.dart';
import 'package:finnhub_project/presentation/pages/list_stocks_page.dart';
import 'package:finnhub_project/utils/constants.dart';
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
          builder: (context) => FadeInRight(
            duration: const Duration(
              milliseconds: Constants.pageTransitionDuration,
            ),
            child: const HomePage(),
          ),
        );
      case Routes.listStock:
        return MaterialPageRoute(
          builder: (context) => FadeInRight(
            duration: const Duration(
              milliseconds: Constants.pageTransitionDuration,
            ),
            child: const ListStockPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}
