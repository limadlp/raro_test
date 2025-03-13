import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsSummaryModel extends PaymentsSummaryEntity {
  const PaymentsSummaryModel({required super.label, required super.value});

  factory PaymentsSummaryModel.fromJson(Map<String, dynamic> map) {
    return PaymentsSummaryModel(label: map["label"] ?? "", value: ConverterHelper.dynamicToDouble(map['value'] ?? 0.0));
  }
}
