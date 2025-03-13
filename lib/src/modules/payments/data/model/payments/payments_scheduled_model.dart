import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsScheduledModel extends PaymentsScheduledEntity {
  const PaymentsScheduledModel({
    required super.paymentDate,
    required super.principal,
    required super.interest,
    required super.total,
    required super.outstandingBalance,
    required super.pastDue,
    required super.status,
    required super.paymentType,
    required super.paymentDateFormatted,
  });

  factory PaymentsScheduledModel.fromJson(Map<String, dynamic> map) {
    return PaymentsScheduledModel(
      paymentDate: DateTime.parse(map['paymentDate'] ?? ""),
      paymentDateFormatted: ConverterHelper.stringNullableToMMDDYYYY(map['paymentDate']),
      principal: ConverterHelper.dynamicToDouble(map['principal'] ?? 0.0),
      interest: ConverterHelper.dynamicToDouble(map['interest'] ?? 0.0),
      total: ConverterHelper.dynamicToDouble(map['total'] ?? 0.0),
      outstandingBalance: ConverterHelper.dynamicToDouble(map['outstandingBalance'] ?? 0.0),
      pastDue: map['pastDue'] ?? false,
      status: map['status'] ?? "",
      paymentType: map['paymentType'] ?? "",
    );
  }
}
