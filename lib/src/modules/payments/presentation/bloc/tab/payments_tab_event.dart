import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_state.dart';

abstract class PaymentsTabEvent {}

class SelectPaymentsTab extends PaymentsTabEvent {
  final PaymentsTab tab;
  SelectPaymentsTab(this.tab);
}
