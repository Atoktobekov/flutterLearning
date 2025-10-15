import 'package:flutter/material.dart';

import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

class CryptoCoinTile extends StatelessWidget {
  final CryptoCoin coin;

  const CryptoCoinTile({super.key, required this.coin});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: Image.network(coin.imageUrl),

      title: Text(coin.name, style: theme.textTheme.bodyMedium),

      subtitle: Text("${coin.priceUSD} \$", style: theme.textTheme.titleSmall),

      trailing: const Icon(Icons.arrow_forward_ios),

      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coin);
      },
    );
  }
}