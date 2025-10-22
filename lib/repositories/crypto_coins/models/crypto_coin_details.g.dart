// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'crypto_coin_details.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CryptoCoinDetailsAdapter extends TypeAdapter<CryptoCoinDetails> {
  @override
  final int typeId = 1;

  @override
  CryptoCoinDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CryptoCoinDetails(
      priceUSD: fields[5] as double,
      imageUrl: fields[6] as String,
      toSymbol: fields[0] as String,
      lastUpdate: fields[1] as DateTime,
      high24Hours: fields[2] as double,
      low24Hours: fields[3] as double,
      change24Hours: fields[4] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CryptoCoinDetails obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.toSymbol)
      ..writeByte(1)
      ..write(obj.lastUpdate)
      ..writeByte(2)
      ..write(obj.high24Hours)
      ..writeByte(3)
      ..write(obj.low24Hours)
      ..writeByte(4)
      ..write(obj.change24Hours)
      ..writeByte(5)
      ..write(obj.priceUSD)
      ..writeByte(6)
      ..write(obj.imageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CryptoCoinDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CryptoCoinDetails _$CryptoCoinDetailsFromJson(Map<String, dynamic> json) =>
    CryptoCoinDetails(
      priceUSD: (json['PRICE'] as num).toDouble(),
      imageUrl: json['IMAGEURL'] as String,
      toSymbol: json['TOSYMBOL'] as String,
      lastUpdate: CryptoCoinDetails._dateTimeFromJson(
          (json['LASTUPDATE'] as num).toInt()),
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
