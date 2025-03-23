import 'package:base_project/src/core/ui/tokens/app_colors.dart';
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

            final entries = state.options.entries.toList();

            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: sheetHeight,
                maxHeight: sheetHeight,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Additional information",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 8),

                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: entries.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 0),
                      itemBuilder: (context, index) {
                        final entry = entries[index];
                        final isLocked = index < 3;

                        return Theme(
                          data: Theme.of(context).copyWith(
                            checkboxTheme: CheckboxThemeData(
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                (states) {
                                  if (isLocked) {
                                    return Colors.grey;
                                  }
                                  if (states.contains(WidgetState.selected)) {
                                    return Colors.green;
                                  }
                                  return Colors.white;
                                },
                              ),
                              checkColor: WidgetStateProperty.all(Colors.white),
                            ),
                          ),
                          child: CheckboxListTile(
                            dense: true,
                            visualDensity: VisualDensity.compact,
                            value: isLocked ? true : entry.value,
                            onChanged:
                                isLocked
                                    ? null
                                    : (_) {
                                      context
                                          .read<TransactionsFilterBloc>()
                                          .add(
                                            ToggleTransactionOption(entry.key),
                                          );
                                    },
                            title: Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            controlAffinity: ListTileControlAffinity.leading,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            checkboxShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
