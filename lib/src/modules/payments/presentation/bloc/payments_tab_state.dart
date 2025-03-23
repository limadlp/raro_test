import 'package:equatable/equatable.dart';

enum PaymentsTab { scheduled, transactions }

class PaymentsTabState extends Equatable {
  final PaymentsTab selectedTab;

  const PaymentsTabState(this.selectedTab);

  @override
  List<Object?> get props => [selectedTab];
}
