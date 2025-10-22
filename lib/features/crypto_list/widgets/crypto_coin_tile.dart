import 'dart:math';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinTile extends StatelessWidget {
  final CryptoCoin coin;

  const CryptoCoinTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final formattedPrice =
    (coin.name == "AID" || coin.name == 'DOV' || coin.name == "CAG")
        ? coin.details.priceUSD : roundTo(coin.details.priceUSD, 3);
    final theme = Theme.of(context);
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: coin.details.fullImageUrl,
        width: 40,
        height: 40,
        placeholder: (context, url) => const CircularProgressIndicator(strokeWidth: 2),
        errorWidget: (context, url, error) => Image.asset('assets/images/placeholder.png', width: 40, height: 40),
      ),

      title: Text(coin.name, style: theme.textTheme.bodyMedium),

      subtitle: Text("$formattedPrice \$", style: theme.textTheme.titleSmall),

      trailing: const Icon(Icons.arrow_forward_ios),

      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin);
      },
    );
  }
}

double roundTo(double value, int places) {
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}