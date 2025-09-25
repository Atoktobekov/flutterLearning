import 'package:flutter/material.dart';
import 'text_theme.dart';

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

  textTheme: textTheme,
);
