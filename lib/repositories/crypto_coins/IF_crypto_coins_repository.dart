import 'crypto_coins.dart';

abstract interface class IfCryptoCoinsRepository{
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoinDetails> getCoinDetails(String currencyCode);
}