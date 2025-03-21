import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:flutter/material.dart';

class PaymentsListTile extends StatelessWidget {
  final PaymentsScheduledEntity payment;

  const PaymentsListTile({super.key, required this.payment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 2,
        child: ListTile(
          title: Text(
            "Data: ${payment.paymentDateFormatted}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Principal: R\$ ${payment.principal.toStringAsFixed(2)}"),
              Text("Juros: R\$ ${payment.interest.toStringAsFixed(2)}"),
              Text("Total: R\$ ${payment.total.toStringAsFixed(2)}"),
              Text(
                "Saldo pendente: R\$ ${payment.outstandingBalance.toStringAsFixed(2)}",
              ),
              Text("Status: ${payment.status}"),
              Text("Tipo: ${payment.paymentType}"),
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
