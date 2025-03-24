import 'package:base_project/src/core/ui/widgets/formatted_currency_text.dart';
import 'package:flutter/material.dart';

class PaymentsSummaryCard extends StatelessWidget {
  final String label;
  final double value;

  const PaymentsSummaryCard({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.black87),
              ),
              const SizedBox(height: 4),
              FormattedCurrencyText(value: value),
            ],
          ),
        ),
      ),
    );
  }
}
