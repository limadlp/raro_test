import 'package:base_project/src/core/ui/widgets/inline_link_parser.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_state.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_tab_bar.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_transaction_tile.dart';
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
                      padding: const EdgeInsets.all(16),
                      child: InlineLinkParser(
                        text: "Do you want to make a payment? #Click here#.",
                        linkDisabled: true,
                        onLinkTap: (text) => print("Clicked"),
                      ),
                    ),
                  ),
                  PaymentsTabBar(tabController: _tabController),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((_, index) {
                      return isScheduledTab
                          ? const PaymentsScheduledShimmerTile()
                          : const PaymentsTransactionShimmerTile();
                    }, childCount: 5),
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
                          padding: EdgeInsets.all(16),
                          child: SizedBox(),
                        ),
                      )
                      : SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(16),

                          child: InlineLinkParser(
                            text:
                                "Do you want to make a payment? #Click here#.",
                            onLinkTap: (text) => print("Clicked"),
                          ),
                        ),
                      ),
                  PaymentsTabBar(tabController: _tabController),
                  if (isScheduledTab)
                    paymentsInfo.paymentsScheduled.isEmpty
                        ? SliverFillRemaining(
                          //TODO: melhorar a mensagem
                          child: Text("No scheduled payments."),
                        )
                        : SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => PaymentsScheduledTile(
                              payment: paymentsInfo.paymentsScheduled[index],
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
                        if (paymentsInfo.transactions.isEmpty) {
                          return SliverFillRemaining(
                            //TODO: melhorar a mensagem
                            child: Text("No transactions available."),
                          );
                        }

                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) => PaymentsTransactionTile(
                              transaction: paymentsInfo.transactions[index],
                              options: filterState.options,
                            ),
                            childCount: paymentsInfo.transactions.length,
                          ),
                        );
                      },
                    ),
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
