part of "crypto_coin_details_bloc.dart";


abstract interface class CryptoCoinDetailsEvent extends Equatable {
  const CryptoCoinDetailsEvent();

  @override
  List<Object?> get props => [];
}

class LoadCryptoCoinDetails extends CryptoCoinDetailsEvent {
  final Completer? completer;

  const LoadCryptoCoinDetails({
    required this.currencyCode,
    this.completer
  });

  final String currencyCode;

  @override
  List<Object?> get props =>  [...super.props, currencyCode, completer];
}