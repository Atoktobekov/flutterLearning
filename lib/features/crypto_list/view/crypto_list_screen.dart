import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:learning/features/crypto_list/widgets/widgets.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:learning/repositories/models/crypto_coin.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  List<CryptoCoin>? _cryptoCoinsList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Currencies List"),
        centerTitle: true,
      ),

      body: (_cryptoCoinsList == null)
          ? const SizedBox()
          : ListView.separated(
              separatorBuilder: (context, index) =>
                  Divider(color: theme.dividerColor),
              itemCount: _cryptoCoinsList!.length,
              itemBuilder: (context, i) {
                final coin = _cryptoCoinsList![i];
                return CryptoCoinTile(coin: coin);
              },
            ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.download),
        onPressed: () async {
          _cryptoCoinsList = await CryptoCoinsRepository().getCoinsList();
          setState(() {});
        },
      ),
    );
  }
}
