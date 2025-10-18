import 'dart:async';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:learning/repositories/crypto_coins/crypto_coins.dart';
import 'package:talker_flutter/talker_flutter.dart';
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
    } catch (exception, stackTrace) {
      emit(CryptoListLoadingFailure(exception));
      GetIt.instance<Talker>().handle(exception, stackTrace);
    }
    finally {
      event.completer?.complete();
    }
    });
  }

  final IfCryptoCoinsRepository _coinsRepository;

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.instance<Talker>().handle(error, stackTrace, "message from onError method of BLoC");
  }
}
