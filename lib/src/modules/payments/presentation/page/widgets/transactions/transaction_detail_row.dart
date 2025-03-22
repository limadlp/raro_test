import 'package:base_project/src/core/ui/tokens/app_typography.dart';
import 'package:flutter/material.dart';

class TransactionDetailRow extends StatelessWidget {
  final String leftLabel;
  final String leftValue;
  final String rightLabel;
  final String rightValue;

  const TransactionDetailRow({
    super.key,
    required this.leftLabel,
    required this.leftValue,
    required this.rightLabel,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(leftLabel, style: AppTypography.caption),
              const SizedBox(height: 1),
              Text(leftValue, style: AppTypography.bodyBold),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(rightLabel, style: AppTypography.caption),
              const SizedBox(height: 1),
              Text(rightValue, style: AppTypography.bodyBold),
            ],
          ),
        ),
      ],
    );
  }
}
