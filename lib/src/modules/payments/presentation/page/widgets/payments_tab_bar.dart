import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/payments_transaction_filter.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/bottom_sheet/transactions_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTabBar extends StatelessWidget {
  final TabController tabController;
  final bool menuEnabled;

  const PaymentsTabBar({
    super.key,
    required this.tabController,
    this.menuEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                controller: tabController,
                tabs: const [Tab(text: "SCHEDULE"), Tab(text: "TRANSACTIONS")],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color:
                    menuEnabled
                        ? Theme.of(context).iconTheme.color
                        : Theme.of(context).disabledColor,
              ),
              tooltip: menuEnabled ? 'Transaction Filters' : 'Menu disabled',
              style: IconButton.styleFrom(
                shape: const RoundedRectangleBorder(),
              ),
              onPressed:
                  menuEnabled
                      ? () async {
                        final currentFilters =
                            BlocProvider.of<TransactionsFilterBloc>(
                              context,
                            ).state.filters;

                        final newFilters = await showModalBottomSheet<
                          List<PaymentsTransactionFilter>
                        >(
                          context: context,
                          isDismissible: true, // arrastar para baixo
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder:
                              (_) => TransactionsFilterBottomSheet(
                                initialFilters: currentFilters,
                              ),
                        );

                        if (newFilters != null && context.mounted) {
                          BlocProvider.of<TransactionsFilterBloc>(
                            context,
                          ).add(SetTransactionFilters(newFilters));
                        }
                      }
                      : null,
            ),
          ],
        ),
      ),
    );
  }
}
