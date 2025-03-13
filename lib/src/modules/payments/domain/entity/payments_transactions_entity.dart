import 'package:equatable/equatable.dart';

abstract class PaymentsTransactionsEntity extends Equatable {
  final String key;
  final DateTime actualPaymentPostDate;
  final DateTime processDate;
  final double actualPaymentAmount;
  final double actualPrincipalPaymentAmount;
  final double actualInterestPaymentAmount;
  final double outstandingPrincipalBalance;
  final double outstandingLoanBalance;
  final double actualFee;
  final String paymentType;

  const PaymentsTransactionsEntity({
    required this.key,
    required this.actualPaymentPostDate,
    required this.processDate,
    required this.actualPaymentAmount,
    required this.actualPrincipalPaymentAmount,
    required this.actualInterestPaymentAmount,
    required this.outstandingPrincipalBalance,
    required this.outstandingLoanBalance,
    required this.actualFee,
    required this.paymentType,
  });

  @override
  List<Object> get props {
    return [
      actualPaymentPostDate,
      processDate,
      actualPaymentAmount,
      actualPrincipalPaymentAmount,
      actualInterestPaymentAmount,
      outstandingPrincipalBalance,
      outstandingLoanBalance,
      actualFee,
      paymentType,
    ];
  }

  Map<String, dynamic> toMap();
}
