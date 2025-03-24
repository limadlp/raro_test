import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsTabBloc extends Bloc<PaymentsTabEvent, PaymentsTabState> {
  PaymentsTabBloc() : super(PaymentsTabState(PaymentsTab.scheduled)) {
    on<SelectPaymentsTab>((event, emit) {
      emit(PaymentsTabState(event.tab));
    });
  }
}
