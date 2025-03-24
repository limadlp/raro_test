import 'package:base_project/src/modules/payments/domain/usecase/get_payments_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payments_event.dart';
import 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final GetPaymentsUseCase getPaymentsUseCase;

  PaymentsBloc(this.getPaymentsUseCase) : super(PaymentsInitial()) {
    on<LoadPayments>((event, emit) async {
      emit(PaymentsLoading());

      final result = await getPaymentsUseCase();

      result.fold(
        (failure) => emit(PaymentsError(failure)),
        (paymentsInfo) => emit(PaymentsLoaded(paymentsInfo)),
      );
    });
  }
}
