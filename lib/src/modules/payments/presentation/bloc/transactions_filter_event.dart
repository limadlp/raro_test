import 'package:equatable/equatable.dart';

abstract class TransactionsFilterEvent extends Equatable {
  const TransactionsFilterEvent();

  @override
  List<Object> get props => [];
}

class ToggleTransactionOption extends TransactionsFilterEvent {
  final String option;

  const ToggleTransactionOption(this.option);

  @override
  List<Object> get props => [option];
}
