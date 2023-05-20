import 'package:flutter/material.dart';

const lightBackgroundColor = Color(0xFFECECEC);

final lightTheme = ThemeData.from(
  colorScheme: const ColorScheme.light(
    background: lightBackgroundColor,
    primary: Colors.grey,
  ),
).copyWith(
  typography: Typography.material2021(),
  textTheme: TextTheme(
    headlineMedium: TextStyle(
      fontFamily: 'RobotoMedium',
      fontSize: 34.0,
      color: Colors.black.withOpacity(0.75),
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 24.0,
      color: Colors.black.withOpacity(0.65),
    ),
    titleLarge: TextStyle(
      fontFamily: 'RobotoMedium',
      fontSize: 20.0,
      color: Colors.black.withOpacity(0.65),
    ),
    titleMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      color: Colors.black.withOpacity(0.65),
    ),
    bodyLarge: TextStyle(
      fontFamily: 'RobotoMedium',
      fontSize: 14.0,
      color: Colors.black.withOpacity(0.65),
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Roboto',
      fontSize: 14.0,
      color: Colors.black.withOpacity(0.65),
    ),
  ),
);
