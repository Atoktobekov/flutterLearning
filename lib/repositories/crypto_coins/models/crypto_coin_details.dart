import 'package:learning/repositories/crypto_coins/models/crypto_coin.dart';

class CryptoCoinDetails extends CryptoCoin {
  const CryptoCoinDetails({
    required super.name,
    required super.priceUSD,
    required super.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hour,
    required this.low24Hours,
  });

  // TOSYMBOL
  final String toSymbol;

  // LASTUPDATE
  final DateTime lastUpdate;

  // HIGH24HOUR
  final double high24Hour;

  // LOW24HOUR
  final double low24Hours;

  @override
  List<Object?> get props => super.props
    ..addAll([
      toSymbol,
      lastUpdate,
      high24Hour,
      low24Hours,
    ]);
}
