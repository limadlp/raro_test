import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_filter_event.dart';
import 'transactions_filter_state.dart';

class TransactionsFilterBloc
    extends Bloc<TransactionsFilterEvent, TransactionsFilterState> {
  TransactionsFilterBloc()
    : super(
        const TransactionsFilterState({
          "Processed Date": true,
          "Amount": true,
          "Type": true,
          "Posted Date": false,
          "Principal Paid": false,
          "Interest Paid": false,
          "Fee": false,
          "Outstanding Principal": false,
          "Outstanding Loan Balance": false,
        }),
      ) {
    on<ToggleTransactionOption>((event, emit) {
      final updatedOptions = Map<String, bool>.from(state.options);
      updatedOptions[event.option] = !updatedOptions[event.option]!;
      emit(TransactionsFilterState(updatedOptions));
    });
  }
}
