import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_scheduled_tile.dart';
import 'package:flutter/material.dart';

class PaymentsScheduledList extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;

  const PaymentsScheduledList({super.key, required this.paymentsInfo});

  @override
  Widget build(BuildContext context) {
    final payments = paymentsInfo.paymentsScheduled;

    if (payments.isEmpty) {
      return const Center(child: Text("No scheduled payments."));
    }

    return ListView.builder(
      itemCount: payments.length,
      itemBuilder:
          (_, index) => PaymentsScheduledTile(payment: payments[index]),
    );
  }
}
