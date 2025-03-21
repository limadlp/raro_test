import 'package:base_project/src/core/ui/widgets/inline_link_parser.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_scheduled_list.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_shimmer.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_transactions_list.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/transactions_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';

class PaymentsPage extends StatelessWidget {
  const PaymentsPage({super.key});

  void _openFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: Modular.get<TransactionsFilterBloc>(),
          child: const TransactionsFilterBottomSheet(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => Modular.get<PaymentsBloc>()..add(LoadPayments()),
        ),
        BlocProvider(create: (_) => Modular.get<TransactionsFilterBloc>()),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(title: const Text("Payments")),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: InlineLinkParser(
                  text: "Do you want to make a payment? #Click here#.",
                  onLinkTap: (linkText) => print("Clicked"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TabBar(
                        isScrollable: false,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(text: "Scheduled"),
                          Tab(text: "Transactions"),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => _openFilterBottomSheet(context),
                      tooltip: 'Transaction Filters',
                      style: IconButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<PaymentsBloc, PaymentsState>(
                  builder: (context, state) {
                    if (state is PaymentsLoading) {
                      return const PaymentsShimmer();
                    } else if (state is PaymentsLoaded) {
                      return TabBarView(
                        children: [
                          PaymentsScheduledList(
                            paymentsInfo: state.paymentsInfo,
                          ),
                          PaymentsTransactionsList(
                            paymentsInfo: state.paymentsInfo,
                          ),
                        ],
                      );
                    } else if (state is PaymentsError) {
                      return Center(
                        child: Text("Error: ${state.failure.message}"),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
