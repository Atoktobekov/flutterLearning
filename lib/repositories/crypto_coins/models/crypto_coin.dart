import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

part 'crypto_coin.g.dart';

@HiveType(typeId: 2)
class CryptoCoin extends Equatable{
  const CryptoCoin({
    required this.name,
    required this.details
  });

  @HiveField(0)
  final String name;

  @HiveField(1)
  final CryptoCoinDetails details;

  @override
  String toString() => name;

  @override
  List<Object?> get props => [name, details];
}
