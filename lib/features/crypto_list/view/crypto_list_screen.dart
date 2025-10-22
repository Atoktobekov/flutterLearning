import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:learning/features/crypto_list/widgets/widgets.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:learning/theme/theme.dart';
import 'package:talker_flutter/talker_flutter.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _cryptoListBloc = CryptoListBloc(
    GetIt.instance<IfCryptoCoinsRepository>(),
  );

  @override
  void initState() {
    _cryptoListBloc.add(LoadCryptoList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = darkTheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Currencies List"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      TalkerScreen(talker: GetIt.instance<Talker>()),
                ),
              );
            },
            icon: const Icon(
              Icons.document_scanner_outlined,
              color: Colors.white60,
            ),
          ),
        ],
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _cryptoListBloc.add(LoadCryptoList(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _cryptoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              final message = state.infoMessage;
              return Column(
                children: [
                  if (message != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 6.0),
                      child: Text(
                        message,
                        style: theme.textTheme.titleSmall!.copyWith(color: Colors.grey),
                      ),
                    ),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(top: 16),
                      separatorBuilder: (context, index) =>
                          Divider(color: theme.dividerColor),
                      itemCount: state.coinsList.length,
                      itemBuilder: (context, i) {
                        final coin = state.coinsList[i];
                        return CryptoCoinTile(coin: coin);
                      },
                    ),
                  ),
                ],
              );
            }
            if (state is CryptoListLoadingFailure) {
              final message = state.exception.toString();
              final isOffline = message.contains("cached");

              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      isOffline ? "No internet connection" : "Something went wrong",
                      style: theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isOffline
                          ? "Please check your connection and try again"
                          : "Please try again later",
                      style: theme.textTheme.labelSmall,
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _cryptoListBloc.add(LoadCryptoList());
                      },
                      child: Text(
                        "Try again",
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: Colors.yellowAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
