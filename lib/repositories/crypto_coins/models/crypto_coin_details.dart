import 'package:learning/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinDetails extends CryptoCoin {
  const CryptoCoinDetails({
    required super.name,
    required super.priceUSD,
    required super.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hours,
    required this.low24Hours,
    required this.change24Hours
  });

  // TOSYMBOL
  final String toSymbol;

  // LASTUPDATE
  final DateTime lastUpdate;

  // HIGH24HOUR
  final double high24Hours;

  // LOW24HOUR
  final double low24Hours;

  //change in 24 hours
  final double change24Hours;

  @override
  List<Object?> get props => super.props
    ..addAll([
      toSymbol,
      lastUpdate,
      high24Hours,
      low24Hours,
      change24Hours
    ]);
}
