import 'package:base_project/src/core/ui/tokens/app_colors.dart';
import 'package:base_project/src/core/ui/widgets/formatted_currency_text.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:flutter/material.dart';

class PaymentsScheduledTile extends StatelessWidget {
  final PaymentsScheduledEntity payment;
  final bool isNext;

  const PaymentsScheduledTile({
    super.key,
    required this.payment,
    this.isNext = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  payment.paymentDateFormatted,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  spacing: 8,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: FormattedCurrencyText(value: payment.total),
                        ),
                      ),
                    ),

                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child:
                            isNext
                                ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.08,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Text(
                                    'Next',
                                    style: TextStyle(color: AppColors.primary),
                                  ),
                                )
                                : const SizedBox.shrink(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
