import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_state.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_transaction_tile.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/shimmer/payments_transaction_shimmer_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTransactionsSliver extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;
  final bool isLoading;

  const PaymentsTransactionsSliver({
    super.key,
    required this.paymentsInfo,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => const PaymentsTransactionShimmerTile(),
          childCount: 5,
        ),
      );
    }

    return BlocBuilder<TransactionsFilterBloc, TransactionsFilterState>(
      builder: (_, state) {
        final transactions = paymentsInfo.transactions;

        if (transactions.isEmpty) {
          return SliverFillRemaining(
            child: Center(child: Text("No transactions available.")),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => PaymentsTransactionTile(
              transaction: transactions[index],
              options: state.options,
            ),
            childCount: transactions.length,
          ),
        );
      },
    );
  }
}
