import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
               
void main() {
  runApp(const CryptoCurrenciesList());
}

class CryptoCurrenciesList extends StatelessWidget {
  const CryptoCurrenciesList({super.key});

  // This widget is the root of your application.
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
      home: const MyHomePage(title: 'Crypto Currencies List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          ),
      ),
    );
  }
}
