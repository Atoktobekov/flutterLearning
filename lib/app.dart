import 'package:flutter/material.dart';
import 'package:learning/router/router.dart';
import 'package:learning/theme/theme.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}