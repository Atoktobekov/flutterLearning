import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'dart:math';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:talker_flutter/talker_flutter.dart';
class CryptoCoinsRepository implements IfCryptoCoinsRepository{

  CryptoCoinsRepository({required this.dio});

  final Dio dio;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
      final response = await dio.get(
        "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,SOL,BNB,AVAX,AID,DOV,CAG&tsyms=USD",
      );

      final data = response.data as Map<String, dynamic>;
      final dataRaw = data['RAW'] as Map<String, dynamic>;

      final cryptoCoinsList = dataRaw.entries.map((entry) {
        final usdData =
            (entry.value as Map<String, dynamic>)['USD']
                as Map<String, dynamic>;

        final price = usdData['PRICE'];
        final imageURL = usdData['IMAGEURL'];
        return CryptoCoin(
            name: entry.key,
            priceUSD: (entry.key == "DOV" ||entry.key == "CAG" || entry.key == "AID") ? price : roundTo(price, 3),
            imageUrl:"https://www.cryptocompare.com/$imageURL");
      }).toList();

      return cryptoCoinsList;
    }

  @override
  Future<CryptoCoinDetails> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final double price = usdData['PRICE'];
    final imageUrl = usdData['IMAGEURL'];
    final toSymbol = usdData['TOSYMBOL'];
    final lastUpdate = usdData['LASTUPDATE'];
    final high24Hour = usdData['HIGH24HOUR'];
    final low24Hours = usdData['LOW24HOUR'];
    final double change24Hours = (usdData["CHANGE24HOUR"] as num).toDouble();

    return CryptoCoinDetails(
      name: currencyCode,
      priceUSD: (currencyCode == "AID" || currencyCode == "DOV" || currencyCode == "CAG") ? price : roundTo(price, 6),
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(lastUpdate),
      high24Hours: (currencyCode == "AID" || currencyCode == "DOV" || currencyCode == "CAG") ? high24Hour : roundTo(high24Hour, 3),
      low24Hours: (currencyCode == "AID" || currencyCode == "DOV" || currencyCode == "CAG") ? low24Hours : roundTo(low24Hours, 3),
      change24Hours: (currencyCode == "AID" || currencyCode == "DOV" || currencyCode == "CAG") ? change24Hours : roundTo(change24Hours, 3)
    );
  }

  double roundTo(double value, int places) {
    try {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  catch (e){
      GetIt.instance<Talker>().info(e);
      return 1.0;
  }
  }
}
