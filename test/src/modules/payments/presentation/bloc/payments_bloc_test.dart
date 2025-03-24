import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_event.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetPaymentsUseCase extends Mock implements GetPaymentsUseCase {}

class FakePaymentsInfo extends Fake implements PaymentsInfoEntity {}

void main() {
  late GetPaymentsUseCase useCase;

  setUpAll(() {
    registerFallbackValue(FakePaymentsInfo());
  });

  setUp(() {
    useCase = MockGetPaymentsUseCase();
  });

  blocTest<PaymentsBloc, PaymentsState>(
    'emits [PaymentsLoading, PaymentsLoaded] on success',
    build: () {
      when(() => useCase()).thenAnswer((_) async => Right(FakePaymentsInfo()));
      return PaymentsBloc(useCase);
    },
    act: (bloc) => bloc.add(LoadPayments()),
    expect: () => [PaymentsLoading(), isA<PaymentsLoaded>()],
  );

  blocTest<PaymentsBloc, PaymentsState>(
    'emits [PaymentsLoading, PaymentsError] on failure',
    build: () {
      when(() => useCase()).thenAnswer((_) async => Left(GenericFailure()));
      return PaymentsBloc(useCase);
    },
    act: (bloc) => bloc.add(LoadPayments()),
    expect: () => [PaymentsLoading(), isA<PaymentsError>()],
  );
}
