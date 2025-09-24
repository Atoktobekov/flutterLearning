import '../features/crypto_list/view/view.dart';
import '../features/crypto_screen/view/view.dart';

final routes = {
  '/': (context) => CryptoListScreen(title: "Crypto Currencies List"),
  '/coin': (context) => CryptoCoinScreen(),
};
