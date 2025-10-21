import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "crypto_coin_details.g.dart";

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

  @JsonKey(name: 'TOSYMBOL')
  final String toSymbol;

  @JsonKey(
    name: 'LASTUPDATE',
    fromJson: _dateTimeFromJson,
    toJson: _dateTimeToJson,
  )
  final DateTime lastUpdate;

  @JsonKey(name: 'HIGH24HOUR')
  final double high24Hours;

  @JsonKey(name: 'LOW24HOUR')
  final double low24Hours;

  @JsonKey(name: "CHANGE24HOUR")
  final double change24Hours;

  @JsonKey(name: 'PRICE')
  final double priceUSD;

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

  static DateTime _dateTimeFromJson(int milliseconds) =>
      DateTime.fromMillisecondsSinceEpoch(milliseconds);
}
