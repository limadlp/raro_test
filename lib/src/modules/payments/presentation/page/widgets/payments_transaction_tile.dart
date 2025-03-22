import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/transactions/transaction_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PaymentsTransactionTile extends StatelessWidget {
  final PaymentsTransactionsEntity transaction;
  final Map<String, bool> options;

  const PaymentsTransactionTile({
    super.key,
    required this.transaction,
    required this.options,
  });

  @override
  Widget build(BuildContext context) {
    final visibleFields = <_Field>[];

    for (final entry in options.entries) {
      if (entry.value) {
        final label = entry.key;
        final value = _getFormattedValue(label, transaction);
        if (value != null) {
          visibleFields.add(_Field(label, value));
        }
      }
    }

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
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: rows),
    );
  }

  String? _getFormattedValue(String key, PaymentsTransactionsEntity t) {
    switch (key) {
      case 'Processed Date':
        return DateFormat.yMMMd().format(t.processDate);
      case 'Posted Date':
        return DateFormat.yMMMd().format(t.actualPaymentPostDate);
      case 'Amount':
        return ConverterHelper.currencyFormatter(t.actualPaymentAmount);
      case 'Principal Paid':
        return ConverterHelper.currencyFormatter(
          t.actualPrincipalPaymentAmount,
        );
      case 'Interest Paid':
        return ConverterHelper.currencyFormatter(t.actualInterestPaymentAmount);
      case 'Fee':
        return ConverterHelper.currencyFormatter(t.actualFee);
      case 'Outstanding Principal':
        return ConverterHelper.currencyFormatter(t.outstandingPrincipalBalance);
      case 'Outstanding Loan Balance':
        return ConverterHelper.currencyFormatter(t.outstandingLoanBalance);
      case 'Type':
        return t.paymentType;
      default:
        return null;
    }
  }
}

class _Field {
  final String label;
  final String value;

  _Field(this.label, this.value);
}
