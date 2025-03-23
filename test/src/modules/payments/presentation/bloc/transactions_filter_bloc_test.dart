import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TransactionsFilterBloc', () {
    late Map<String, bool> initialOptions;

    setUp(() {
      initialOptions = const {
        "Processed Date": true,
        "Amount": true,
        "Type": true,
        "Posted Date": false,
        "Principal Paid": false,
        "Interest Paid": false,
        "Fee": false,
        "Outstanding Principal": false,
        "Outstanding Loan Balance": false,
      };
    });

    test('has correct initial state', () {
      final bloc = TransactionsFilterBloc();
      expect(bloc.state.options, initialOptions);
    });

    blocTest<TransactionsFilterBloc, TransactionsFilterState>(
      'should toggle "Processed Date" from true to false',
      build: () => TransactionsFilterBloc(),
      act: (bloc) => bloc.add(const ToggleTransactionOption("Processed Date")),
      expect: () {
        final updated = Map<String, bool>.from(initialOptions);
        updated["Processed Date"] = false;

        return [TransactionsFilterState(updated)];
      },
    );

    blocTest<TransactionsFilterBloc, TransactionsFilterState>(
      'should toggle "Fee" from false to true',
      build: () => TransactionsFilterBloc(),
      act: (bloc) => bloc.add(const ToggleTransactionOption("Fee")),
      expect: () {
        final updated = Map<String, bool>.from(initialOptions);
        updated["Fee"] = true;

        return [TransactionsFilterState(updated)];
      },
    );
  });
}
