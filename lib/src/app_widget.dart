import 'package:flutter/material.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF232F69))),
      home: const PaymentsTransactionsPage(),
    );
  }
}

class PaymentsTransactionsPage extends StatelessWidget {
  const PaymentsTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Color(0xFF232F69)));
  }
}
