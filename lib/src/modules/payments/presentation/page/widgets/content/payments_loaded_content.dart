import 'package:base_project/src/core/ui/ui.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsLoadedContent extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;
  final bool isScheduledTab;
  final TabController tabController;

  const PaymentsLoadedContent({
    super.key,
    required this.paymentsInfo,
    required this.isScheduledTab,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        _buildSummary(paymentsInfo),
        PaymentsTabBar(
          tabController: tabController,
          menuEnabled: paymentsInfo.transactions.isNotEmpty,
        ),
        isScheduledTab
            ? _buildScheduled(paymentsInfo)
            : _buildTransactions(paymentsInfo),
        const SliverToBoxAdapter(child: SizedBox(height: 48)),
      ],
    );
  }

  Widget _buildSummary(PaymentsInfoEntity paymentsInfo) {
    if (paymentsInfo.paymentsScheduled.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: SizedBox(),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ...paymentsInfo.summary.map(
                  (summary) => Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: PaymentsSummaryCard(
                      label: summary.label,
                      value: summary.value,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
              child: InlineLinkParser(
                text: "Do you want to make a payment? #Click here#.",
                onLinkTap: (text) {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduled(PaymentsInfoEntity paymentsInfo) {
    if (paymentsInfo.paymentsScheduled.isEmpty) {
      return const SliverFillRemaining(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text(
            "Once your loan is booked your payment\n schedule will appear here. This process may take\n 1-2 business days.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
              color: AppColors.textDisabled,
            ),
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => PaymentsScheduledTile(
          payment: paymentsInfo.paymentsScheduled[index],
          isNext: index == 0,
        ),
        childCount: paymentsInfo.paymentsScheduled.length,
      ),
    );
  }

  Widget _buildTransactions(PaymentsInfoEntity paymentsInfo) {
    return BlocBuilder<TransactionsFilterBloc, TransactionsFilterState>(
      builder: (context, filterState) {
        final options = {
          for (var f in filterState.filters) f.label: f.isSelected,
        };

        if (paymentsInfo.transactions.isEmpty) {
          return const SliverFillRemaining(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                "Once you begin your payments they will appear\n here. This process may take 1-2 business days.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                  color: AppColors.textDisabled,
                ),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PaymentsTransactionTile(
              transaction: paymentsInfo.transactions[index],
              options: options,
            ),
            childCount: paymentsInfo.transactions.length,
          ),
        );
      },
    );
  }
}
