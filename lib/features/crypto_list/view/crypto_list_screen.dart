import 'package:flutter/material.dart';
import 'package:learning/features/crypto_list/widgets/widgets.dart';


class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Currencies List"),
        centerTitle: true,
      ),

      body: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(color: theme.dividerColor),
        itemCount: 20,
        itemBuilder: (context, i) {
          const coinName = 'Bitcoin';

          return const CryptoCoinTile(coinName: coinName);
        },
      ),
    );
  }
}


