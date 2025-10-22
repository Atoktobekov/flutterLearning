part of 'crypto_list_bloc.dart';

abstract interface class CryptoListState extends Equatable{}

class CryptoListInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({required this.coinsList, this.infoMessage});

  final List<CryptoCoin> coinsList;
  final String? infoMessage;

  @override
  List<Object?> get props => [coinsList, infoMessage];
}

class CryptoListLoadingFailure extends CryptoListState{
  CryptoListLoadingFailure(this.exception);

  final Object? exception;

  @override
  List<Object?> get props => [exception];

}
