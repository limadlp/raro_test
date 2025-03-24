import 'package:base_project/src/core/ui/tokens/app_typography.dart';
import 'package:base_project/src/core/ui/widgets/formatted_currency_text.dart';
import 'package:flutter/material.dart';

class TransactionDetailRow extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final dynamic leftValue;
  final dynamic rightValue;

  const TransactionDetailRow({
    super.key,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    Widget formatValue(dynamic value) {
      if (value is Widget) return value;
      if (value is double) return FormattedCurrencyText(value: value);
      return Text(value.toString(), style: AppTypography.bodyBold);
    }

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(leftLabel, style: AppTypography.caption),
              const SizedBox(height: 1),
              formatValue(leftValue),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rightLabel, style: AppTypography.caption),
              const SizedBox(height: 1),
              formatValue(rightValue),
            ],
          ),
        ),
      ],
    );
  }
}
