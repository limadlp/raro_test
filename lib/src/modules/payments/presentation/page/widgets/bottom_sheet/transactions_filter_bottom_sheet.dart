import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_state.dart';

class TransactionsFilterBottomSheet extends StatelessWidget {
  const TransactionsFilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsFilterBloc, TransactionsFilterState>(
      builder: (context, state) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight;
            final estimatedContentHeight =
                (state.options.length * 56.0) + 100.0;
            final sheetHeight = estimatedContentHeight.clamp(
              0.0,
              availableHeight * 0.9,
            );

            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: sheetHeight, // Usa o máximo disponível
                maxHeight: sheetHeight,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...state.options.entries.map((entry) {
                        return CheckboxListTile(
                          title: Text(entry.key),
                          value: entry.value,
                          onChanged: (_) {
                            context.read<TransactionsFilterBloc>().add(
                              ToggleTransactionOption(entry.key),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
