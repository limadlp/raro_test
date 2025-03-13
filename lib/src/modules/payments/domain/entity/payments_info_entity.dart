import 'package:equatable/equatable.dart';

import 'entity.dart';

abstract class PaymentsInfoEntity extends Equatable {
  final List<PaymentsScheduledEntity> paymentsScheduled;
  final List<PaymentsSummaryEntity> summary;
  final List<PaymentsTransactionFilterEntity> transactionFilter;
  final List<PaymentsTransactionsEntity> transactions;

  const PaymentsInfoEntity({
    required this.paymentsScheduled,
    required this.summary,
    required this.transactionFilter,
    required this.transactions,
  });

  @override
  List<Object> get props => [paymentsScheduled, summary, transactionFilter, transactions];
}
