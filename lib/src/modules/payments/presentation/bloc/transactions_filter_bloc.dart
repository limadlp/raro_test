import 'package:flutter_bloc/flutter_bloc.dart';
import 'transactions_filter_event.dart';
import 'transactions_filter_state.dart';

class TransactionsFilterBloc
    extends Bloc<TransactionsFilterEvent, TransactionsFilterState> {
  TransactionsFilterBloc()
    : super(
        const TransactionsFilterState({
          "Posted Date": true,
          "Processed Date": true,
          "Amount": true,
          "Principal Paid": true,
          "Interest Paid": true,
          "Fee": true,
          "Outstanding Principal": true,
          "Outstanding Loan Balance": true,
          "Type": true,
        }),
      ) {
    on<ToggleTransactionOption>((event, emit) {
      final updatedOptions = Map<String, bool>.from(state.options);
      updatedOptions[event.option] = !updatedOptions[event.option]!;
      emit(TransactionsFilterState(updatedOptions));
    });
  }
}
