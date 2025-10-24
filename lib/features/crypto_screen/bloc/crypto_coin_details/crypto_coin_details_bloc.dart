import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';

part 'crypto_coin_details_event.dart';

part 'crypto_coin_details_state.dart';

class CryptoCoinDetailsBloc
    extends Bloc<CryptoCoinDetailsEvent, CryptoCoinDetailsState> {
  CryptoCoinDetailsBloc(this.coinsRepository)
    : super(const CryptoCoinDetailsState()) {
    on<LoadCryptoCoinDetails>(_load);
  }

  final IfCryptoCoinsRepository coinsRepository;

  Future<void> _load(
    LoadCryptoCoinDetails event,
    Emitter<CryptoCoinDetailsState> emit,
  ) async {
    try {
      if (state is! CryptoCoinDetailsLoaded) {
        emit(const CryptoCoinDetailsLoading());
      }

      final coinDetails = await coinsRepository.getCoinDetails(
        event.currencyCode,
      );

      // TTL Filtering
      final lastUpdate = coinDetails.details.lastUpdate;
      final age = DateTime.now().difference(lastUpdate);

      if (age.inMinutes > 15) {
        emit(
          CryptoCoinDetailsLoadingFailure(
            Exception(
              "Cached coin details are older than 15 minutes. Please enable internet.",
            ),
          ),
        );
        event.completer?.complete();
        return;
      }

      emit(CryptoCoinDetailsLoaded(coinDetails));
    } catch (e) {
      emit(CryptoCoinDetailsLoadingFailure(e));
    } finally {
      event.completer?.complete();
    }
  }
}
