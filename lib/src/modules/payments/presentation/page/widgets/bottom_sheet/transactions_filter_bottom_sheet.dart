import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/payments_transaction_filter.dart';

class TransactionsFilterBottomSheet extends StatefulWidget {
  final List<PaymentsTransactionFilter> initialFilters;

  const TransactionsFilterBottomSheet({
    super.key,
    required this.initialFilters,
  });

  @override
  State<TransactionsFilterBottomSheet> createState() =>
      _TransactionsFilterBottomSheetState();
}

class _TransactionsFilterBottomSheetState
    extends State<TransactionsFilterBottomSheet> {
  late Map<String, bool> localOptions;
  bool hasReturnedResult = false;

  @override
  void initState() {
    super.initState();
    localOptions = {for (var f in widget.initialFilters) f.label: f.isSelected};
  }

  void _applyAndClose() {
    if (hasReturnedResult) return;
    hasReturnedResult = true;

    final updatedFilters =
        widget.initialFilters.map((filter) {
          return filter.copyWith(
            isSelected: localOptions[filter.label] ?? filter.isSelected,
          );
        }).toList();

    Navigator.of(context).pop(updatedFilters);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (_) {
        return false;
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) async {
          _applyAndClose();
        },
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.9,
          builder: (_, scrollController) {
            final entries = localOptions.entries.toList();

            return Material(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
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
                          onPressed: _applyAndClose,
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.separated(
                      controller: scrollController,
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
                                  if (isLocked) return Colors.grey;
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
                                      setState(() {
                                        localOptions[entry.key] = !entry.value;
                                      });
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
        ),
      ),
    );
  }
}
