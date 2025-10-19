import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final talker = TalkerFlutter.init();
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printEventFullData: false,
      printStateFullData: false,
    ),
  );
  GetIt.instance.registerSingleton(talker);

  GetIt.instance<Talker>().debug("Talker started!");

  final dio = Dio();

  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(printResponseData: false),
      talker: talker,
    ),
  );

  final app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  talker.info(app.options.projectId);

  GetIt.instance.registerLazySingleton<IfCryptoCoinsRepository>(
    () => CryptoCoinsRepository(dio: dio),
  );

  FlutterError.onError = (details) =>
      GetIt.instance<Talker>().handle(details.exception, details.stack);

  runZonedGuarded(
    () => runApp(const CryptoCurrenciesListApp()),
    (error, stackTrace) => GetIt.instance<Talker>().handle(error, stackTrace),
  );
}
