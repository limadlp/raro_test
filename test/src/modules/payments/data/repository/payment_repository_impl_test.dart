import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentsDatasource extends Mock implements PaymentsDataSource {}

class MockPaymentsInfo extends Mock implements PaymentsInfoEntity {}

void main() {
  late PaymentsRepositoryImpl repository;
  late PaymentsDataSource datasource;

  setUp(() {
    datasource = MockPaymentsDatasource();
    repository = PaymentsRepositoryImpl(datasource);
  });

  test('should return PaymentsInfoEntity from datasource', () async {
    final mockData = MockPaymentsInfo();
    when(() => datasource.getPaymentsInfo()).thenAnswer((_) async => mockData);

    final result = await repository.getPayments();

    expect(result.isRight(), true);
    expect(result.getOrElse(() => throw Exception()), mockData);
  });

  test('should return GenericFailure when datasource throws', () async {
    when(() => datasource.getPaymentsInfo()).thenThrow(Exception('unexpected'));

    final result = await repository.getPayments();

    expect(result.isLeft(), true);
    expect(result.fold((l) => l, (r) => null), isA<GenericFailure>());
  });
}
