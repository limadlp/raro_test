import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/payments_transaction_filter.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('TransactionsFilterBloc', () {
    late TransactionsFilterBloc bloc;

    List<PaymentsTransactionFilter> getDefaultFilters() =>
        TransactionsFilterBloc().state.filters;

    setUp(() {
      bloc = TransactionsFilterBloc();
    });

    test('has correct initial state', () {
      expect(bloc.state.filters, getDefaultFilters());
    });

    blocTest<TransactionsFilterBloc, TransactionsFilterState>(
      'emits updated state when one filter is toggled',
      build: () => TransactionsFilterBloc(),
      act: (bloc) {
        final updated = List<PaymentsTransactionFilter>.from(
          getDefaultFilters(),
        );
        final first = updated[0];
        updated[0] = first.copyWith(isSelected: !first.isSelected);
        bloc.add(SetTransactionFilters(updated));
      },
      expect: () {
        final updated = List<PaymentsTransactionFilter>.from(
          getDefaultFilters(),
        );
        final first = updated[0];
        updated[0] = first.copyWith(isSelected: !first.isSelected);
        return [TransactionsFilterState(filters: updated)];
      },
    );
  });
}
