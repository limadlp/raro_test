import 'package:flutter/material.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/schedule/payments_scheduled_list.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_transactions_list.dart';

class PaymentsTabView extends StatelessWidget {
  final int selectedIndex;
  final PaymentsInfoEntity paymentsInfo;

  const PaymentsTabView({
    super.key,
    required this.selectedIndex,
    required this.paymentsInfo,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedIndex == 0) {
      return PaymentsScheduledList(paymentsInfo: paymentsInfo);
    } else {
      return PaymentsTransactionsList(paymentsInfo: paymentsInfo);
    }
  }
}
