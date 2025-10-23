import 'crypto_coins.dart';

abstract interface class IfCryptoCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoin> getCoinDetails(String currencyCode);
  List<CryptoCoin> getCachedCoinsList();
}