import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 31, 31, 31),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 22,
      fontWeight: FontWeight.w700,
    ),
    elevation: 1,
    shadowColor: Colors.white24,
  ),

  scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),

  primarySwatch: Colors.yellow,

  dividerColor: Colors.white24,

  listTileTheme: const ListTileThemeData(iconColor: Colors.white),

  textTheme: TextTheme(
    bodyMedium: const TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    titleSmall: TextStyle(
      color: Colors.white.withOpacity(.7),
      fontWeight: FontWeight.w700,
      fontSize: 16,
    ),
  ),
);
