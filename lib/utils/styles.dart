import 'package:flutter/material.dart';

class Styles {
  // Colors

  static const backgroundColor = Color(0xff222222);
  static const mainAppColor = Color(0xff4EAF4B);

  static const textStyleTittle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const textStyleDropdownButton = TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );

  static const textstyleBarChartBottom = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Styles.backgroundColor,
        Styles.backgroundColor,
        Styles.backgroundColor,
        Styles.mainAppColor
      ],
    ),
  );
}
