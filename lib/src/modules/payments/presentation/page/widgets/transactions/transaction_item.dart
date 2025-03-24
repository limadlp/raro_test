import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/transactions/transaction_detail_row.dart';
import 'package:flutter/material.dart';

class TransactionItem extends StatelessWidget {
  final String processDate;
  final double amount;
  final String type;
  final double principal;
  final double interest;
  final String lateFee;
  final double principalBalance;
  final String postDate;
  final bool showPrincipalBalance;

  const TransactionItem({
    super.key,
    required this.processDate,
    required this.amount,
    required this.type,
    required this.principal,
    required this.interest,
    required this.lateFee,
    required this.principalBalance,
    required this.postDate,
    this.showPrincipalBalance = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        children: [
          TransactionDetailRow(
            leftLabel: 'Process date',
            leftValue: processDate,
            rightLabel: 'Amount',
            rightValue: ConverterHelper.currencyFormatter(amount),
          ),
          const SizedBox(height: 16),
          TransactionDetailRow(
            leftLabel: 'Type',
            leftValue: type,
            rightLabel: 'Principal',
            rightValue: ConverterHelper.currencyFormatter(principal),
          ),
          const SizedBox(height: 16),
          TransactionDetailRow(
            leftLabel: 'Late Fee',
            leftValue: lateFee,
            rightLabel: 'Interest',
            rightValue: ConverterHelper.currencyFormatter(interest),
          ),
          if (showPrincipalBalance) ...[
            const SizedBox(height: 16),
            TransactionDetailRow(
              leftLabel: 'Principal Balance',
              leftValue: ConverterHelper.currencyFormatter(principalBalance),
              rightLabel: 'Post date',
              rightValue: postDate,
            ),
          ],
        ],
      ),
    );
  }
}
