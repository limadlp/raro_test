import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentsRepository extends Mock implements PaymentsRepository {}

class MockPaymentsInfoEntity extends Mock implements PaymentsInfoEntity {}

class MockPaymentsScheduledEntity extends Mock
    implements PaymentsScheduledEntity {}

void main() {
  late GetPaymentsUseCase usecase;
  late MockPaymentsRepository repository;

  setUp(() {
    repository = MockPaymentsRepository();
    usecase = GetPaymentsUseCase(repository);
  });

  test('should filter and sort future scheduled payments', () async {
    final now = DateTime.now();

    final pastPayment = MockPaymentsScheduledEntity();
    when(
      () => pastPayment.paymentDate,
    ).thenReturn(now.subtract(const Duration(days: 2)));

    final futurePayment = MockPaymentsScheduledEntity();
    when(
      () => futurePayment.paymentDate,
    ).thenReturn(now.add(const Duration(days: 2)));

    final paymentsInfo = MockPaymentsInfoEntity();
    final scheduledPayments = [pastPayment, futurePayment];

    when(() => paymentsInfo.paymentsScheduled).thenReturn(scheduledPayments);
    when(() => paymentsInfo.summary).thenReturn([]);
    when(() => paymentsInfo.transactionFilter).thenReturn([]);
    when(() => paymentsInfo.transactions).thenReturn([]);

    when(
      () => repository.getPayments(),
    ).thenAnswer((_) async => Right(paymentsInfo));

    final result = await usecase();

    expect(result.isRight(), true);

    final filtered = result.getOrElse(() => throw Exception());
    expect(filtered.paymentsScheduled.length, 1);
    expect(filtered.paymentsScheduled.first.paymentDate.isAfter(now), true);
  });

  test('should return failure when repository fails', () async {
    when(
      () => repository.getPayments(),
    ).thenAnswer((_) async => Left(GenericFailure()));

    final result = await usecase();

    expect(result.isLeft(), true);
  });
}
