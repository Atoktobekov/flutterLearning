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

  @override
  Future<CryptoCoinDetails> getCoinDetails(String currencyCode) async {
    final response = await dio.get(
        'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=$currencyCode&tsyms=USD');

    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final coinData = dataRaw[currencyCode] as Map<String, dynamic>;
    final usdData = coinData['USD'] as Map<String, dynamic>;
    final price = usdData['PRICE'];
    final imageUrl = usdData['IMAGEURL'];
    final toSymbol = usdData['TOSYMBOL'];
    final lastUpdate = usdData['LASTUPDATE'];
    final high24Hour = usdData['HIGH24HOUR'];
    final low24Hours = usdData['LOW24HOUR'];

    return CryptoCoinDetails(
      name: currencyCode,
      priceUSD: price,
      imageUrl: 'https://www.cryptocompare.com/$imageUrl',
      toSymbol: toSymbol,
      lastUpdate: DateTime.fromMillisecondsSinceEpoch(lastUpdate),
      high24Hour: high24Hour,
      low24Hours: low24Hours,
    );
  }
}
