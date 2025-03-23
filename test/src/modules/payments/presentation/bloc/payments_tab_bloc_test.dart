import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_tab_state.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  blocTest<PaymentsTabBloc, PaymentsTabState>(
    'emits new tab when SelectPaymentsTab is added',
    build: () => PaymentsTabBloc(),
    act: (bloc) => bloc.add(SelectPaymentsTab(PaymentsTab.transactions)),
    expect: () => [PaymentsTabState(PaymentsTab.transactions)],
  );
}
