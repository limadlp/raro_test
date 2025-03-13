import 'package:equatable/equatable.dart';

abstract class PaymentsScheduledEntity extends Equatable {
  final DateTime paymentDate;
  final String paymentDateFormatted;
  final double principal;
  final double interest;
  final double total;
  final double outstandingBalance;
  final bool pastDue;
  final String status;
  final String paymentType;

  const PaymentsScheduledEntity({
    required this.paymentDateFormatted,
    required this.paymentDate,
    required this.principal,
    required this.interest,
    required this.total,
    required this.outstandingBalance,
    required this.pastDue,
    required this.status,
    required this.paymentType,
  });

  @override
  List<Object?> get props => [
    paymentDate,
    principal,
    interest,
    total,
    outstandingBalance,
    pastDue,
    status,
    paymentType,
    paymentDateFormatted,
  ];
}
