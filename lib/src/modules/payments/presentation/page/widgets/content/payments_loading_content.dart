import 'package:base_project/src/core/ui/ui.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class PaymentsLoadingContent extends StatelessWidget {
  final TabController tabController;
  final bool isScheduledTab;

  const PaymentsLoadingContent({
    super.key,
    required this.tabController,
    required this.isScheduledTab,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: PaymentsSummaryRowShimmer(),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Center(
              child: InlineLinkParser(
                text: "Do you want to make a payment? #Click here#.",
                linkDisabled: true,
                onLinkTap: (text) {},
              ),
            ),
          ),
        ),
        PaymentsTabBar(tabController: tabController, menuEnabled: false),
        SliverList(
          delegate: SliverChildBuilderDelegate((_, index) {
            return isScheduledTab
                ? const PaymentsScheduledShimmerTile()
                : const PaymentsTransactionShimmerTile();
          }, childCount: isScheduledTab ? 3 : 1),
        ),
      ],
    );
  }
}
