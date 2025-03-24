import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsTransactionFilter extends PaymentsTransactionFilterEntity {
  final bool isSelected;

  const PaymentsTransactionFilter({
    required super.key,
    required super.label,
    required super.isDefault,
    required this.isSelected,
  });

  PaymentsTransactionFilter copyWith({bool? isSelected}) {
    return PaymentsTransactionFilter(
      key: key,
      label: label,
      isDefault: isDefault,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  @override
  List<Object> get props => [key, label, isDefault, isSelected];
}
