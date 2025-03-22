import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/bottom_sheet/transactions_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentsTabBar extends StatelessWidget {
  final TabController tabController;

  const PaymentsTabBar({super.key, required this.tabController});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          children: [
            Expanded(
              child: TabBar(
                controller: tabController,
                tabs: const [Tab(text: "SCHEDULE"), Tab(text: "TRANSACTIONS")],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder:
                      (_) => BlocProvider.value(
                        value: Modular.get<TransactionsFilterBloc>(),
                        child: const TransactionsFilterBottomSheet(),
                      ),
                );
              },
              tooltip: 'Transaction Filters',
              style: IconButton.styleFrom(
                shape: const RoundedRectangleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
