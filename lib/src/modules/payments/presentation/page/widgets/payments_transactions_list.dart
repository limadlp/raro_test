import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_transaction_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_state.dart';

class PaymentsTransactionsList extends StatelessWidget {
  final PaymentsInfoEntity paymentsInfo;

  const PaymentsTransactionsList({super.key, required this.paymentsInfo});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsFilterBloc, TransactionsFilterState>(
      builder: (context, state) {
        final transactions = paymentsInfo.transactions;

        if (transactions.isEmpty) {
          return const Center(child: Text("No transactions available."));
        }

        return ListView.builder(
          itemCount: transactions.length,
          itemBuilder:
              (_, index) => PaymentsTransactionTile(
                transaction: transactions[index],
                options: state.options,
              ),
        );
      },
    );
  }
}
