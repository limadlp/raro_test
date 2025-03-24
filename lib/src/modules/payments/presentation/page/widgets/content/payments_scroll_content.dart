import 'package:base_project/src/modules/payments/presentation/bloc/bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/widgets.dart';
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
        return BlocBuilder<PaymentsBloc, PaymentsState>(
          builder: (context, paymentsState) {
            if (paymentsState is PaymentsLoading) {
              return PaymentsLoadingContent(
                tabController: _tabController,
                isScheduledTab: tabState.selectedTab == PaymentsTab.scheduled,
              );
            }

            if (paymentsState is PaymentsError) {
              return Center(
                child: Text("Error: ${paymentsState.failure.message}"),
              );
            }

            if (paymentsState is PaymentsLoaded) {
              return PaymentsLoadedContent(
                paymentsInfo: paymentsState.paymentsInfo,
                isScheduledTab: tabState.selectedTab == PaymentsTab.scheduled,
                tabController: _tabController,
              );
            }

            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
