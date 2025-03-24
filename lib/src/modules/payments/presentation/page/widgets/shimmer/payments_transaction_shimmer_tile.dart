import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentsTransactionShimmerTile extends StatelessWidget {
  const PaymentsTransactionShimmerTile({super.key});

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _spacedRow({
    required String leftLabel,
    required Widget leftValue,
    required String rightLabel,
    required Widget rightValue,
  }) {
    return Row(
      children: [
        // Left
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_label(leftLabel), const SizedBox(height: 4), leftValue],
          ),
        ),
        const SizedBox(width: 16),
        // Right
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _label(rightLabel),
              const SizedBox(height: 4),
              rightValue,
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _spacedRow(
            leftLabel: 'Process date',
            leftValue: _shimmerBox(),
            rightLabel: 'Amount',
            rightValue: _shimmerBox(),
          ),
          const SizedBox(height: 16),
          _spacedRow(
            leftLabel: 'Type',
            leftValue: _shimmerBox(),
            rightLabel: '',
            rightValue: _shimmerBox(),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox() {
    return Shimmer.fromColors(
      baseColor: AppColors.shimmerBase,
      highlightColor: AppColors.shimmerHighlight,
      child: Container(
        height: 24,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }
}
