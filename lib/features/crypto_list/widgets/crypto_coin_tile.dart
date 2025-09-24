import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CryptoCoinTile extends StatelessWidget {
  final String coinName;

  const CryptoCoinTile({super.key, required this.coinName});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
      leading: SvgPicture.asset(
        'assets/images/svg/bitcoin.svg',
        height: 25,
        width: 25,
      ),

      title: Text(coinName, style: theme.textTheme.bodyMedium),

      subtitle: Text("20000\$", style: theme.textTheme.titleSmall),

      trailing: const Icon(Icons.arrow_forward_ios),

      onTap: () {
        Navigator.of(context).pushNamed('/coin', arguments: coinName);
      },
    );
  }
}