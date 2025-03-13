import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsTransactionHeadersModel extends PaymentsTransactionFilterEntity {
  const PaymentsTransactionHeadersModel({required super.key, required super.label, required super.isDefault});

  factory PaymentsTransactionHeadersModel.fromJson(Map<String, dynamic> map) {
    return PaymentsTransactionHeadersModel(
      key: map['key'] ?? "",
      label: map['label'] ?? "",
      isDefault: map['isDefault'] ?? false,
    );
  }
}
