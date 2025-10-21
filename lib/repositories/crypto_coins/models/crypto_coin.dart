import 'package:equatable/equatable.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoin extends Equatable{
  const CryptoCoin({
    required this.name,
    required this.details
  });

  final String name;
  final CryptoCoinDetails details;

  @override
  String toString() => name;

  @override
  List<Object?> get props => [name, details];
}
