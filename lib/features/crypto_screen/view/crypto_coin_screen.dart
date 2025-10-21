import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/features/crypto_screen/bloc/crypto_coin_details/crypto_coin_details_bloc.dart';
import 'package:learning/features/crypto_screen/view/widgets/widgets.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

import 'package:learning/theme/theme.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  CryptoCoin? coin;
  final _coinDetailsBloc = CryptoCoinDetailsBloc(
    GetIt.I<IfCryptoCoinsRepository>(),
  );

  Timer? _timer;
  Duration _elapsed = Duration.zero;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(
      args != null && args is CryptoCoin,
      'You must provide CryptoCoin args',
    );
    coin = args as CryptoCoin;
    _coinDetailsBloc.add(LoadCryptoCoinDetails(currencyCode: coin!.name));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Color.fromARGB(255, 238, 238, 238)),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _coinDetailsBloc.add(
            LoadCryptoCoinDetails(
              currencyCode: coin!.name,
              completer: completer,
            ),
          );
          return completer.future;
        },
        child: BlocBuilder<CryptoCoinDetailsBloc, CryptoCoinDetailsState>(
          bloc: _coinDetailsBloc,
          builder: (context, state) {
            if (state is CryptoCoinDetailsLoaded) {
              final coin = state.coin;
              _startTimer(); // start after loading

              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                // <-- IMPORTANT!
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 160,
                      width: 160,
                      child: Image.network(coin.details.fullImageUrl),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      coin.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    BaseCard(
                      child: Center(
                        child: Text(
                          '${roundTo(coin.name, coin.details.priceUSD)} \$',
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    BaseCard(
                      child: Column(
                        children: [
                          _DataRow(
                            title: 'High 24 Hour',
                            value: '${roundTo(coin.name, coin.details.high24Hours)} \$',
                          ),
                          const SizedBox(height: 10),
                          _DataRow(
                            title: 'Low 24 Hour',
                            value: '${roundTo(coin.name, coin.details.low24Hours)} \$',
                          ),
                          const SizedBox(height: 10),
                          _DataRow(
                            title: 'Change 24 Hour',
                            value: '${roundTo(coin.name, coin.details.change24Hours)} \$',
                          ),
                          const SizedBox(height: 10),
                          _DataRow(
                            title: 'Last update',
                            value: _coinDetailsBloc.updateTime == null
                                ? '...'
                                : _formatElapsed(_elapsed),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is CryptoCoinDetailsLoadingFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text("Exception : ${state.exception}"),
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: () {
                        _coinDetailsBloc.add(
                          LoadCryptoCoinDetails(currencyCode: coin!.name),
                        );
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

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final updateTime = _coinDetailsBloc.updateTime;
      if (updateTime != null && mounted) {
        setState(() {
          _elapsed = DateTime.now().difference(updateTime);
        });
      }
    });
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(child: Text(value)),
      ],
    );
  }
}

String _formatElapsed(Duration elapsed) {
  if (elapsed.inSeconds < 60) {
    return '${elapsed.inSeconds} seconds ago';
  } else if (elapsed.inMinutes < 60) {
    return '${elapsed.inMinutes} minutes ago';
  } else if (elapsed.inHours < 24) {
    return '${elapsed.inHours} hours ago';
  } else {
    return '${elapsed.inDays} days ago';
  }
}

double roundTo(String name, double value) {
  if(name == "AID" || name == "CAG" || name == "DOV"){
    return value;
  }
  num mod = pow(10.0, 5);
  return ((value * mod).round().toDouble() / mod);
}