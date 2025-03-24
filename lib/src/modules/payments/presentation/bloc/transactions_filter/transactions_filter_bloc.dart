import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_filter_state.dart';
import 'transactions_filter_event.dart';
import 'payments_transaction_filter.dart';

class TransactionsFilterBloc
    extends Bloc<TransactionsFilterEvent, TransactionsFilterState> {
  TransactionsFilterBloc()
    : super(TransactionsFilterState(filters: _defaultFilters)) {
    on<SetTransactionFilters>(_onSetFilters);
  }

  static List<PaymentsTransactionFilter> get _defaultFilters => const [
    PaymentsTransactionFilter(
      key: "processedDate",
      label: "Processed Date",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "amount",
      label: "Amount",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "type",
      label: "Type",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "postedDate",
      label: "Posted Date",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "principalPaid",
      label: "Principal Paid",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "interestPaid",
      label: "Interest Paid",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "fee",
      label: "Fee",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "outstandingPrincipal",
      label: "Outstanding Principal",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "outstandingLoanBalance",
      label: "Outstanding Loan Balance",
      isDefault: false,
      isSelected: false,
    ),
  ];

  void _onSetFilters(
    SetTransactionFilters event,
    Emitter<TransactionsFilterState> emit,
  ) {
    emit(state.copyWith(filters: event.filters));
  }
}
