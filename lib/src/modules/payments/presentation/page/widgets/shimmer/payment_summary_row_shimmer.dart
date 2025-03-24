import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PaymentsSummaryRowShimmer extends StatelessWidget {
  const PaymentsSummaryRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const labels = [
      'Outstanding Balance',
      'Total Paid',
      'Principal Paid',
      'Interest Paid',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          for (final label in labels) ...[
            _PaymentsSummaryCardShimmer(label: label),
            const SizedBox(width: 12),
          ],
        ],
      ),
    );
  }
}

class _PaymentsSummaryCardShimmer extends StatelessWidget {
  final String label;

  const _PaymentsSummaryCardShimmer({required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: Card(
        elevation: 2,
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
              const SizedBox(height: 12),

              Shimmer.fromColors(
                baseColor: AppColors.shimmerBase,
                highlightColor: AppColors.shimmerHighlight,
                child: Container(
                  height: 24,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
