import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
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
            priceUSD: price,
            imageUrl:"https://www.cryptocompare.com/$imageURL");
      }).toList();

      return cryptoCoinsList;
    }
}
