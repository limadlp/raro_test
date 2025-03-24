import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/model/payments/payments.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/infra/datasource/datasource.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('should throw InfraError on parsing failure', () async {
    final datasource = _InvalidJsonDatasource();

    expect(
      () async => await datasource.getPaymentsInfo(),
      throwsA(isA<InfraError>()),
    );
  });
}

class _InvalidJsonDatasource extends PaymentsDatasourceImpl {
  @override
  Future<PaymentsInfoEntity> getPaymentsInfo() async {
    try {
      final response = await Future.delayed(Duration.zero).then((_) {
        return {
          'paymentsScheduled': [
            {
              'paymentDate': 'not-a-date', // causes an error in DateTime.parse
              'principal': 100,
            },
          ],
        };
      });
      return PaymentsInfoModel.fromJson(response);
    } catch (e) {
      throw InfraError(InfraCode.unexpected, error: e);
    }
  }
}
