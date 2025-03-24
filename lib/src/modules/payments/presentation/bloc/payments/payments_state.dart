import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:equatable/equatable.dart';
import 'package:base_project/src/core/core.dart';

abstract class PaymentsState extends Equatable {
  const PaymentsState();

  @override
  List<Object?> get props => [];
}

class PaymentsInitial extends PaymentsState {}

class PaymentsLoading extends PaymentsState {}

class PaymentsLoaded extends PaymentsState {
  final PaymentsInfoEntity paymentsInfo;

  const PaymentsLoaded(this.paymentsInfo);

  @override
  List<Object?> get props => [paymentsInfo];
}

class PaymentsError extends PaymentsState {
  final Failure failure;

  const PaymentsError(this.failure);

  @override
  List<Object?> get props => [failure];
}
