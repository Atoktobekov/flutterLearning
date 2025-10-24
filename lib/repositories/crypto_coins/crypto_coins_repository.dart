import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:talker_flutter/talker_flutter.dart';

const String apiCall = "https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,SOL,BNB,AVAX,LTC,XRP,DOGE,ADA,TRX,XLM,LINK,UNI&tsyms=USD";

class CryptoCoinsRepository implements IfCryptoCoinsRepository {
  CryptoCoinsRepository({required this.dio, required this.cryptoCoinsBox});

  final Dio dio;
  final Box<CryptoCoin> cryptoCoinsBox;

  @override
  Future<List<CryptoCoin>> getCoinsList() async {
    var cryptoCoinsList = <CryptoCoin>[];

    try {
      cryptoCoinsList = await _fetchCoinsListFromApi();
      final cryptoCoinsMap = {for (var e in cryptoCoinsList) e.name: e};
      cryptoCoinsBox.putAll(cryptoCoinsMap);

      cryptoCoinsList.sort(
        (a, b) => b.details.priceUSD.compareTo(a.details.priceUSD),
      );
      return cryptoCoinsList;
    } catch (e, st) {
      GetIt.instance<Talker>().handle(
        e,
        st,
        "***ERROR from getCoinsList method***",
      );
      rethrow;
    }
  }

  @override
  Future<CryptoCoin> getCoinDetails(String currencyCode) async {
    try {
      final coin = await _fetchCoinDetailsFromApi(currencyCode);
      cryptoCoinsBox.put(currencyCode, coin);
      return coin;
    } catch (e, st) {
      GetIt.instance<Talker>().handle(
        e,
        st,
        "***ERROR from getCoinDetailsMethod***",
      );
      return cryptoCoinsBox.get(currencyCode)!;
    }
  }

  @override
  List<CryptoCoin> getCachedCoinsList() {
    return cryptoCoinsBox.values.toList();
  }

  Future<List<CryptoCoin>> _fetchCoinsListFromApi() async {
    final response = await dio.get(apiCall);
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

  Future<CryptoCoin> _fetchCoinDetailsFromApi(String currencyCode) async {
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
