import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'app.dart';

void main() {
  GetIt.instance.registerLazySingleton<IfCryptoCoinsRepository>(
    () => CryptoCoinsRepository(dio: Dio()),
  );
  runApp(const CryptoCurrenciesListApp());
}
