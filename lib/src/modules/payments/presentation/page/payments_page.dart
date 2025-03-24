import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => Modular.get<PaymentsBloc>()..add(LoadPayments()),
        ),
        BlocProvider(create: (_) => Modular.get<TransactionsFilterBloc>()),
        BlocProvider(create: (_) => PaymentsTabBloc()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Payments"),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () => _showHelpDialog(context),
            ),
          ],
        ),
        body: PaymentsScrollContent(),
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text("Help"),
            content: const Text(
              "This is the payments page. Here you can manage your payments.",
            ),
            actions: [
              TextButton(
                onPressed: () => Modular.to.pop(),
                child: const Text("Close"),
              ),
            ],
          ),
    );
  }
}
