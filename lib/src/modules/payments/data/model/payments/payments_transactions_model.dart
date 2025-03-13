import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';

class PaymentsTransactionsModel extends PaymentsTransactionsEntity {
  const PaymentsTransactionsModel({
    required super.key,
    required super.actualPaymentPostDate,
    required super.processDate,
    required super.actualPaymentAmount,
    required super.actualPrincipalPaymentAmount,
    required super.actualInterestPaymentAmount,
    required super.outstandingPrincipalBalance,
    required super.outstandingLoanBalance,
    required super.actualFee,
    required super.paymentType,
  });

  factory PaymentsTransactionsModel.fromJson(Map<String, dynamic> map) {
    return PaymentsTransactionsModel(
      key: map['key'] ?? "",
      actualPaymentPostDate: DateTime.parse(map['actualPaymentPostDate']),
      processDate: DateTime.parse(map['processDate']),
      actualPaymentAmount: ConverterHelper.dynamicToDouble(map['actualPaymentAmount'] ?? 0.0),
      actualPrincipalPaymentAmount: ConverterHelper.dynamicToDouble(map['actualPrincipalPaymentAmount'] ?? 0.0),
      actualInterestPaymentAmount: ConverterHelper.dynamicToDouble(map['actualInterestPaymentAmount'] ?? 0.0),
      outstandingPrincipalBalance: ConverterHelper.dynamicToDouble(map['outstandingPrincipalBalance'] ?? 0.0),
      outstandingLoanBalance: ConverterHelper.dynamicToDouble(map['outstandingLoanBalance'] ?? 0.0),
      actualFee: ConverterHelper.dynamicToDouble(map['actualFee'] ?? 0.0),
      paymentType: map['paymentType'] ?? "",
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'actualPaymentPostDate': ConverterHelper.stringNullableToMMDDYYYY(actualPaymentPostDate.toIso8601String()),
      'processDate': ConverterHelper.stringNullableToMMDDYYYY(processDate.toIso8601String()),
      'actualPaymentAmount': ConverterHelper.currencyFormatter(actualPaymentAmount, "--"),
      'actualPrincipalPaymentAmount': ConverterHelper.currencyFormatter(actualPrincipalPaymentAmount, "--"),
      'actualInterestPaymentAmount': ConverterHelper.currencyFormatter(actualInterestPaymentAmount, "--"),
      'outstandingPrincipalBalance': ConverterHelper.currencyFormatter(outstandingPrincipalBalance, "--"),
      'outstandingLoanBalance': ConverterHelper.currencyFormatter(outstandingLoanBalance, "--"),
      'actualFee': ConverterHelper.currencyFormatter(actualFee, "--"),
      'type': paymentType,
    };
  }
}
