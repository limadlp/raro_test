import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsTransactionTile extends StatelessWidget {
  final PaymentsTransactionsEntity transaction;
  final Map<String, bool> options;

  const PaymentsTransactionTile({
    super.key,
    required this.transaction,
    required this.options,
  });

  String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_US',
      symbol: '\$',
      decimalDigits: 2,
    ).format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(
          "Processed: ${DateFormat.yMMMd().format(transaction.processDate)}",
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              options.entries.where((e) => e.value).map((e) {
                return Text(
                  "${e.key}: ${formatCurrency(transaction.actualPaymentAmount)}",
                );
              }).toList(),
        ),
      ),
    );
  }
}
