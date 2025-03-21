import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Modular.routerConfig,
      title: 'BMG Money',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF232F69)),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

//TODO: deal with this page
class PaymentsTransactionsPage extends StatelessWidget {
  const PaymentsTransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(color: Color(0xFF232F69)));
  }
}
