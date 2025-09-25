import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;

  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String, 'You must provide String args!');
    coinName = args as String;
    setState(() {}); //setState
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(coinName ?? '...'),
        centerTitle: true,
        leading: BackButton(
          color: Color.fromARGB(255, 238, 238, 238),
        ),
      ),
      body: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 219, 152, 40),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(4, 4),
              ),
            ],
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text("Crypto Coin List", style: TextStyle(fontSize: 22)),
          ),
        ),
      ),
    );
  }
}
