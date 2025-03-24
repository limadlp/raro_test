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
      key: "processDate",
      label: "Process date",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "actualPaymentAmount",
      label: "Amount",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "paymentType",
      label: "Type",
      isDefault: true,
      isSelected: true,
    ),
    PaymentsTransactionFilter(
      key: "actualPrincipalPaymentAmount",
      label: "Principal",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "actualInterestPaymentAmount",
      label: "Interest",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "actualFee",
      label: "Late Fee",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "actualPaymentPostDate",
      label: "Post date",
      isDefault: false,
      isSelected: false,
    ),
    PaymentsTransactionFilter(
      key: "outstandingPrincipalBalance",
      label: "Principal Balance",
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
