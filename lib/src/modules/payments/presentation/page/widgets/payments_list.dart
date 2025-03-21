import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_list_tile.dart';
import 'package:flutter/material.dart';

class PaymentsList extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;

  const PaymentsList({super.key, required this.paymentsInfo});

  @override
  Widget build(BuildContext context) {
    final payments = paymentsInfo.paymentsScheduled;

    if (payments.isEmpty) {
      return const Center(child: Text("Nenhum pagamento agendado."));
    }

    return ListView.builder(
      itemCount: payments.length,
      itemBuilder: (_, index) => PaymentsListTile(payment: payments[index]),
    );
  }
}
