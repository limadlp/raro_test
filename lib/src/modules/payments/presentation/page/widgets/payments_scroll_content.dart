//TODO: arrumar imports
// TODO: Quebrar em widgets menores e arrumar pasta de widgets

import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:base_project/src/core/ui/widgets/inline_link_parser.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_state.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payment_summary_card.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_tab_bar.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/shimmer/payment_summary_row_shimmer.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/transactions/payments_transaction_tile.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/schedule/payments_scheduled_tile.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/shimmer/payments_scheduled_shimmer_tile.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/shimmer/payments_transaction_shimmer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsScrollContent extends StatefulWidget {
  const PaymentsScrollContent({super.key});

  @override
  State<PaymentsScrollContent> createState() => _PaymentsScrollContentState();
}

class _PaymentsScrollContentState extends State<PaymentsScrollContent>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(_onTabChanged);

    final selectedTab = context.read<PaymentsTabBloc>().state.selectedTab;
    _tabController.index = (selectedTab == PaymentsTab.scheduled) ? 0 : 1;
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      context.read<PaymentsTabBloc>().add(
        SelectPaymentsTab(
          _tabController.index == 0
              ? PaymentsTab.scheduled
              : PaymentsTab.transactions,
        ),
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsTabBloc, PaymentsTabState>(
      builder: (context, tabState) {
        final isScheduledTab = tabState.selectedTab == PaymentsTab.scheduled;

        return BlocBuilder<PaymentsBloc, PaymentsState>(
          builder: (context, paymentsState) {
            if (paymentsState is PaymentsError) {
              return Center(
                child: Text("Error: ${paymentsState.failure.message}"),
              );
            }

            if (paymentsState is PaymentsLoading) {
              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: PaymentsSummaryRowShimmer(),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: InlineLinkParser(
                          text: "Do you want to make a payment? #Click here#.",
                          linkDisabled: true,
                          onLinkTap: (text) => () {},
                        ),
                      ),
                    ),
                  ),
                  PaymentsTabBar(
                    tabController: _tabController,
                    menuEnabled: false,
                  ),
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

            if (paymentsState is PaymentsLoaded) {
              final paymentsInfo = paymentsState.paymentsInfo;
              return CustomScrollView(
                slivers: [
                  paymentsInfo.paymentsScheduled.isEmpty
                      ? const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: SizedBox(),
                        ),
                      )
                      : SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 16,
                              ),
                              child: Center(
                                child: InlineLinkParser(
                                  text:
                                      "Do you want to make a payment? #Click here#.",
                                  onLinkTap: (text) => {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  PaymentsTabBar(
                    tabController: _tabController,
                    menuEnabled: paymentsInfo.transactions.isNotEmpty,
                  ),
                  if (isScheduledTab)
                    paymentsInfo.paymentsScheduled.isEmpty
                        ? SliverFillRemaining(
                          child: Padding(
                            padding: const EdgeInsets.all(32.0),
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
                        )
                        : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => PaymentsScheduledTile(
                              payment: paymentsInfo.paymentsScheduled[index],
                              isNext: index == 0,
                            ),
                            childCount: paymentsInfo.paymentsScheduled.length,
                          ),
                        )
                  else
                    BlocBuilder<
                      TransactionsFilterBloc,
                      TransactionsFilterState
                    >(
                      builder: (_, filterState) {
                        final options = {
                          for (var f in filterState.filters)
                            f.label: f.isSelected,
                        };

                        if (paymentsInfo.transactions.isEmpty) {
                          return SliverFillRemaining(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
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
                          delegate: SliverChildBuilderDelegate((
                            context,
                            index,
                          ) {
                            return PaymentsTransactionTile(
                              transaction: paymentsInfo.transactions[index],
                              options: options,
                            );
                          }, childCount: paymentsInfo.transactions.length),
                        );
                      },
                    ),
                  SliverToBoxAdapter(child: SizedBox(height: 48)),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
