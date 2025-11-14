import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'crypto_list_event.dart';

part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState> {
  CryptoListBloc(this._coinsRepository) : super(CryptoListInitial()) {
    on<LoadCryptoList>((event, emit) async {
      try {
        if (state is! CryptoListLoaded) {
          emit(CryptoListLoading());
        }

        final coinsList = await _coinsRepository.getCoinsList();
        emit(CryptoListLoaded(coinsList: coinsList));
      } catch (exception, stackTrace) {
        final message = exception.toString();

        if (message.contains("The connection errored: ")) {
          final lastData = _coinsRepository.getCachedCoinsList();

          // TTL Filtering
          final freshData = lastData.where((coin) {
            final lastUpdate = coin.details.lastUpdate;
            final age = DateTime.now().difference(lastUpdate); // Duration
            return age.inMinutes <= 15;
          }).toList();

          if (freshData.isNotEmpty) {
            freshData.sort(
              (a, b) => b.details.priceUSD.compareTo(a.details.priceUSD),
            );
            emit(
              CryptoListLoaded(
                coinsList: freshData,
                infoMessage: "No internet connection, showing last data",
              ),
            );
          } else {
            emit(
              CryptoListLoadingFailure(
                Exception(
                  "No internet connection and cached data is older than 15 minutes",
                ),
              ),
            );
          }
        } else {
          emit(CryptoListLoadingFailure(exception));
        }

        GetIt.instance<Talker>().handle(exception, stackTrace, "[CryptoListBlocError]");
      } finally {
        event.completer?.complete();
      }
    });
  }

  final IfCryptoCoinsRepository _coinsRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.instance<Talker>().handle(
      error,
      stackTrace,
      "message from onError method of BLoC",
    );
  }
}
