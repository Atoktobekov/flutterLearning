class CryptoCoin {
  const CryptoCoin({
    required this.name,
    required this.priceUSD,
    required this.imageUrl
  });

  final String name;
  final double priceUSD;
  final String imageUrl;

  @override
  String toString() => "$name: $priceUSD USD";
}
