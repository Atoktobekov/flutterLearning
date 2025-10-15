import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
part 'crypto_list_event.dart';
part 'crypto_list_state.dart';

class CryptoListBloc extends Bloc<CryptoListEvent, CryptoListState>{
  CryptoListBloc(this._coinsRepository) : super(CryptoListInitial()){
    on<LoadCryptoList>((event, emit) async {
    try {
      if(state is! CryptoListLoaded){
        emit(CryptoListLoading());
      }
      final coinsList = await _coinsRepository.getCoinsList();
      emit(CryptoListLoaded(coinsList: coinsList));
    } catch (e) {
      emit(CryptoListLoadingFailure(e));
    }
    finally {
      event.completer?.complete();
    }
    });
  }

  final IfCryptoCoinsRepository _coinsRepository;
}
