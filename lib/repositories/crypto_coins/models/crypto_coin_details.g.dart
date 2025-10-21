// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      priceUSD: (json['PRICE'] as num).toDouble(),
      imageUrl: json['IMAGEURL'] as String,
      toSymbol: json['TOSYMBOL'] as String,
      lastUpdate: CryptoCoinDetails._dateTimeFromJson(
        (json['LASTUPDATE'] as num).toInt(),
      ),
      high24Hours: (json['HIGH24HOUR'] as num).toDouble(),
      low24Hours: (json['LOW24HOUR'] as num).toDouble(),
      change24Hours: (json['CHANGE24HOUR'] as num).toDouble(),
    );

Map<String, dynamic> _$CryptoCoinDetailsToJson(CryptoCoinDetails instance) =>
    <String, dynamic>{
      'TOSYMBOL': instance.toSymbol,
      'LASTUPDATE': CryptoCoinDetails._dateTimeToJson(instance.lastUpdate),
      'HIGH24HOUR': instance.high24Hours,
      'LOW24HOUR': instance.low24Hours,
      'CHANGE24HOUR': instance.change24Hours,
      'PRICE': instance.priceUSD,
      'IMAGEURL': instance.imageUrl,
    };
