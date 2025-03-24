import 'package:equatable/equatable.dart';
import 'payments_transaction_filter.dart';

class TransactionsFilterState extends Equatable {
  final List<PaymentsTransactionFilter> filters;

  const TransactionsFilterState({required this.filters});

  TransactionsFilterState copyWith({List<PaymentsTransactionFilter>? filters}) {
    return TransactionsFilterState(filters: filters ?? this.filters);
  }

  @override
  List<Object> get props => [filters];
}
