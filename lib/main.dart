import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
               
void main() {
  runApp(const CryptoCurrenciesList());
}

class CryptoCurrenciesList extends StatelessWidget {
  const CryptoCurrenciesList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            backgroundColor:  const Color.fromARGB(255, 31, 31, 31),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            elevation: 1,
            shadowColor: Colors.white24,
        ),

        scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),

        primarySwatch: Colors.yellow,

        dividerColor: Colors.white24,

        listTileTheme: const ListTileThemeData(iconColor: Colors.white),

        textTheme: TextTheme(
          bodyMedium: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),

          titleSmall: TextStyle(
            color: Colors.white.withOpacity(.7),
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),

        )
      ),
      //home: const CryptoListScreen(title: 'Crypto Currencies List'),
      routes: {
        '/': (context) => CryptoListScreen(title: "Crypto Currencies List"),
        '/coin': (context) => CryptoCoinScreen()
      },
    );
  }
}

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key, required this.title});

  final String title;

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Crypto Currencies List"),
        centerTitle: true,
      ),

      body: ListView.separated(
          separatorBuilder: (context, index) =>  Divider(color: theme.dividerColor,),
          itemCount: 20,
          itemBuilder: (context, i) =>
              ListTile(
          leading: SvgPicture.asset('assets/images/svg/bitcoin.svg', height: 25, width: 25,),
          
          title: Text("Bitcoin",
              style: theme.textTheme.bodyMedium),
          
          subtitle: Text("20000\$",
              style: theme.textTheme.titleSmall),
                
          trailing: const Icon(
              Icons.arrow_forward_ios
             ),

          onTap: () {
              Navigator.of(context).pushNamed(
                '/coin'
            );
          },
        ),
      ),
    );
  }
}


class CryptoCoinScreen extends StatelessWidget {
  const CryptoCoinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is CryptoListScreen"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white60,),
            onPressed: () {
              Navigator.of(context).pushNamed(
                  '/'
              );
            },
        ),
      ),
    );
  }
}
