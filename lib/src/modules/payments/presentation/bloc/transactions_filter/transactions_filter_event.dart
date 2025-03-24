import 'package:equatable/equatable.dart';
import 'payments_transaction_filter.dart';

abstract class TransactionsFilterEvent extends Equatable {
  const TransactionsFilterEvent();

  @override
  List<Object> get props => [];
}

class SetTransactionFilters extends TransactionsFilterEvent {
  final List<PaymentsTransactionFilter> filters;

  const SetTransactionFilters(this.filters);

  @override
  List<Object> get props => [filters];
}
