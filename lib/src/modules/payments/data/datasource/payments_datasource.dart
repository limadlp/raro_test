import 'package:base_project/src/modules/payments/domain/domain.dart';

abstract class PaymentsDataSource {
  Future<PaymentsInfoEntity> getPaymentsInfo();
}
