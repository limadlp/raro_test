import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/schedule/payments_scheduled_tile.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/shimmer/payments_scheduled_shimmer_tile.dart';
import 'package:flutter/material.dart';

class PaymentsScheduledSliver extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;
  final bool isLoading;

  const PaymentsScheduledSliver({
    super.key,
    required this.paymentsInfo,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const PaymentsScheduledShimmerTile(),
          childCount: 5,
        ),
      );
    }

    final items = paymentsInfo.paymentsScheduled;

    if (items.isEmpty) {
      return SliverFillRemaining(
        child: Center(child: Text("No scheduled payments.")),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => PaymentsScheduledTile(payment: items[index]),
        childCount: items.length,
      ),
    );
  }
}
