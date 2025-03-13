import 'package:equatable/equatable.dart';

abstract class PaymentsTransactionFilterEntity extends Equatable {
  final String key;
  final String label;
  final bool isDefault;

  const PaymentsTransactionFilterEntity({required this.key, required this.label, required this.isDefault});

  @override
  List<Object> get props => [key, label, isDefault];
}
