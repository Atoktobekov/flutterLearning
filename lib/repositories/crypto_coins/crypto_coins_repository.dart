import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:learning/repositories/models/crypto_coin.dart';

class CryptoCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList() async {
    try {
      final response = await Dio().get(
        "https://min-api.cryptocompare.com/data/pricemulti?fsyms=BTC,ETH,BNB,AVAX&tsyms=USD",
      );

      final data = response.data as Map<String, dynamic>;

      final cryptoCoinsList = data.entries.map((entry) {
        final symbol = entry.key; // "BTC", "ETH" ...
        final coinData =
            entry.value as Map<String, dynamic>; // {"USD": 61234.56}
        return CryptoCoin.fromJson(symbol, coinData);
      }).toList();

      return cryptoCoinsList;
    } catch (e) {
      log("Ошибка при запросе: $e");
      return [];
    }
  }
}
