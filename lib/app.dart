import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/router/router.dart';
import 'package:learning/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoCurrenciesListApp extends StatelessWidget {
  const CryptoCurrenciesListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      routes: routes,
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        TalkerRouteObserver(GetIt.instance<Talker>()),
      ],
    );
  }
}