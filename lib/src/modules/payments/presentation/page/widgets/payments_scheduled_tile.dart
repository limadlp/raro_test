import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsScheduledTile extends StatelessWidget {
  final PaymentsScheduledEntity payment;

  const PaymentsScheduledTile({super.key, required this.payment});

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            "Due: ${payment.paymentDateFormatted}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Principal: ${formatCurrency(payment.principal)}"),
              Text("Interest: ${formatCurrency(payment.interest)}"),
              Text("Total: ${formatCurrency(payment.total)}"),
              Text(
                "Outstanding Balance: ${formatCurrency(payment.outstandingBalance)}",
              ),
              Text("Status: ${payment.status}"),
              Text("Type: ${payment.paymentType}"),
            ],
          ),
          trailing: Icon(
            Icons.warning_amber_rounded,
            color: payment.pastDue ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
