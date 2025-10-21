import 'package:dio/dio.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinsRepository implements IfCryptoCoinsRepository {
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
          (entry.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;

      final details = CryptoCoinDetails.fromJson(usdData);

      return CryptoCoin(name: entry.key, details: details);
    }).toList();

    return cryptoCoinsList;
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
      'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD',
    );

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final details = CryptoCoinDetails.fromJson(usdData);

    return CryptoCoin(name: currencyCode, details: details);
  }


}
