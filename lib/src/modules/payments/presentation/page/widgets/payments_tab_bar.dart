import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/bottom_sheet/transactions_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

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
              onPressed:
                  menuEnabled
                      ? () {
                        showModalBottomSheet(
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(12),
                            ),
                          ),
                          builder:
                              (_) => BlocProvider.value(
                                value: Modular.get<TransactionsFilterBloc>(),
                                child: const TransactionsFilterBottomSheet(),
                              ),
                        );
                      }
                      : null,
              tooltip: menuEnabled ? 'Transaction Filters' : 'Menu disabled',
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
