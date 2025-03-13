import 'package:equatable/equatable.dart';

abstract class PaymentsSummaryEntity extends Equatable {
  final String label;
  final double value;

  const PaymentsSummaryEntity({required this.label, required this.value});

  @override
  List<Object?> get props => [label, value];
}
