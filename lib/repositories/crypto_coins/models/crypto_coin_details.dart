import 'package:equatable/equatable.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part "crypto_coin_details.g.dart";

@HiveType(typeId: 1)
@JsonSerializable()
class CryptoCoinDetails extends Equatable {
  const CryptoCoinDetails({
    required this.priceUSD,
    required this.imageUrl,
    required this.toSymbol,
    required this.lastUpdate,
    required this.high24Hours,
    required this.low24Hours,
    required this.change24Hours,
  });

  @HiveField(0)
  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @HiveField(1)
  @JsonKey(
    name: 'LASTUPDATE',
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime lastUpdate;

  @HiveField(2)
  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hours;

  @HiveField(3)
  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  @HiveField(4)
  @JsonKey(name: "CHANGE24HOUR")
  final double change24Hours;

  @HiveField(5)
  @JsonKey(name: 'PRICE')
  final double priceUSD;

  @HiveField(6)
  @JsonKey(name: 'IMAGEURL')
  final String imageUrl;

  String get fullImageUrl => "https://cryptocompare.com/$imageUrl";

  @override
  List<Object?> get props => [
    toSymbol,
    lastUpdate,
    high24Hours,
    low24Hours,
    change24Hours,
    priceUSD,
    imageUrl,
  ];

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) =>
      _$CryptoCoinDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CryptoCoinDetailsToJson(this);

  static int _dateTimeToJson(DateTime time) => time.millisecondsSinceEpoch;

  static DateTime _dateTimeFromJson(int seconds) =>
      DateTime.fromMillisecondsSinceEpoch(seconds*1000);
}
