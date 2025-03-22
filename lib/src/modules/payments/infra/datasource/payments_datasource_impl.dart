import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/infra/mock/mock.dart';

class PaymentsDatasourceImpl implements PaymentsDataSource {
  PaymentsDatasourceImpl();

  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    try {
      final response = await Future.delayed(Duration(milliseconds: 3500)).then((
        _,
      ) {
        // INFO: use mockEmptyJson or mockPaymentsJson

        //return mockPaymentsJson; /* mockEmptyJson */
        return mockEmptyJson; /* mockEmptyJson */
      });
      return PaymentsInfoModel.fromJson(response);
    } catch (e) {
      throw InfraError(InfraCode.unexpected, error: e);
    }
  }
}
