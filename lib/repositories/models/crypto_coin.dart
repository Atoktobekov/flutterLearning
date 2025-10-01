class CryptoCoin {
  const CryptoCoin({
    required this.name,
    required this.priceUSD,
    required this.imageUrl
  });

  final String name;
  final double priceUSD;
  final String imageUrl;
/*
  factory CryptoCoin.fromJson(String symbol, Map<String, dynamic> json) {
    return CryptoCoin(
      name: symbol,
      priceUSD: (json["USD"] as num).toDouble(),
    );
  }*/

  @override
  String toString() => "$name: $priceUSD USD";
}
