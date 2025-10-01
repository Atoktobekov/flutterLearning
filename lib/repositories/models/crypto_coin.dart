class CryptoCoin {
  const CryptoCoin({
    required this.name,
    required this.priceUSD
  });

  final String name;
  final double priceUSD;


  factory CryptoCoin.fromJson(String symbol, Map<String, dynamic> json) {
    return CryptoCoin(
      name: symbol,
      priceUSD: (json["USD"] as num).toDouble(),
    );
  }

  @override
  String toString() => "$name: $priceUSD USD";
}
