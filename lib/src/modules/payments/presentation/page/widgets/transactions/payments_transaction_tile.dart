// melhorar o shimmer

import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/core/ui/widgets/formatted_currency_text.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/transactions/transaction_detail_row.dart';
import 'package:flutter/material.dart';

class PaymentsTransactionTile extends StatelessWidget {
  final PaymentsTransactionsEntity transaction;
  final Map<String, bool> options;

  const PaymentsTransactionTile({
    super.key,
    required this.transaction,
    required this.options,
  });

  static const fieldOrder = [
    'Process date',
    'Amount',
    'Type',
    'Principal',
    'Late Fee',
    'Interest',
    'Principal Balance',
    'Post date',
  ];

  @override
  Widget build(BuildContext context) {
    final allFields = _buildFields(transaction);

    final visibleFields =
        fieldOrder
            .where((label) => options[label] ?? false)
            .map((label) => _Field(label: label, value: allFields[label]!))
            .toList();

    final rows = <Widget>[];
    for (int i = 0; i < visibleFields.length; i += 2) {
      final left = visibleFields[i];
      final right = i + 1 < visibleFields.length ? visibleFields[i + 1] : null;

      rows.add(
        TransactionDetailRow(
          leftLabel: left.label,
          leftValue: left.value,
          rightLabel: right?.label ?? '',
          rightValue: right?.value ?? '',
        ),
      );

      if (i + 2 < visibleFields.length) {
        rows.add(const SizedBox(height: 16));
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: rows),
    );
  }

  Map<String, dynamic> _buildFields(PaymentsTransactionsEntity t) {
    return {
      'Process date': ConverterHelper.stringNullableToMMDDYYYY(
        t.processDate.toIso8601String(),
      ),
      'Amount': FormattedCurrencyText(value: t.actualPaymentAmount),
      'Type': _mapPaymentType(t.paymentType),
      'Principal': FormattedCurrencyText(value: t.actualPrincipalPaymentAmount),
      'Late Fee': FormattedCurrencyText(value: t.actualFee),
      'Interest': FormattedCurrencyText(value: t.actualInterestPaymentAmount),
      'Principal Balance': FormattedCurrencyText(
        value: t.outstandingPrincipalBalance,
      ),
      'Post date': ConverterHelper.stringNullableToMMDDYYYY(
        t.actualPaymentPostDate.toIso8601String(),
      ),
    };
  }

  String _mapPaymentType(String type) {
    return switch (type) {
      'PaymentType1' => 'Payroll Deduction',
      'PaymentType2' => 'Debit Card',
      _ => type,
    };
  }
}

class _Field {
  final String label;
  final dynamic value;

  const _Field({required this.label, required this.value});
}
