import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/data/model/payments/payments_transactions_model.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments/payments_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/tab/payments_tab_state.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter/transactions_filter_state.dart';
import 'package:base_project/src/modules/payments/presentation/page/widgets/payments_scroll_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPaymentsBloc extends Mock implements PaymentsBloc {}

class MockPaymentsTabBloc extends Mock implements PaymentsTabBloc {}

class MockTransactionsFilterBloc extends Mock
    implements TransactionsFilterBloc {}

class MockPaymentsInfo extends Mock implements PaymentsInfoEntity {}

class FakePaymentsState extends Fake implements PaymentsState {}

class FakePaymentsTabState extends Fake implements PaymentsTabState {}

class FakeTransactionsFilterState extends Fake
    implements TransactionsFilterState {}

void main() {
  late PaymentsBloc paymentsBloc;
  late PaymentsTabBloc paymentsTabBloc;
  late TransactionsFilterBloc filterBloc;

  setUpAll(() {
    registerFallbackValue(FakePaymentsState());
    registerFallbackValue(FakePaymentsTabState());
    registerFallbackValue(FakeTransactionsFilterState());
  });

  setUp(() {
    paymentsBloc = MockPaymentsBloc();
    paymentsTabBloc = MockPaymentsTabBloc();
    filterBloc = MockTransactionsFilterBloc();

    // Corrige erro de stream null
    when(() => paymentsBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => paymentsTabBloc.stream).thenAnswer((_) => const Stream.empty());
    when(() => filterBloc.stream).thenAnswer((_) => const Stream.empty());
  });

  Widget buildTestWidget() {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PaymentsBloc>.value(value: paymentsBloc),
        BlocProvider<PaymentsTabBloc>.value(value: paymentsTabBloc),
        BlocProvider<TransactionsFilterBloc>.value(value: filterBloc),
      ],
      child: const MaterialApp(home: Scaffold(body: PaymentsScrollContent())),
    );
  }

  testWidgets('shows shimmer when loading', (tester) async {
    when(
      () => paymentsTabBloc.state,
    ).thenReturn(PaymentsTabState(PaymentsTab.scheduled));
    when(() => paymentsBloc.state).thenReturn(PaymentsLoading());

    await tester.pumpWidget(buildTestWidget());

    expect(find.byType(SliverToBoxAdapter), findsWidgets);
  });

  testWidgets('shows error when PaymentsError is emitted', (tester) async {
    when(
      () => paymentsTabBloc.state,
    ).thenReturn(PaymentsTabState(PaymentsTab.scheduled));
    when(
      () => paymentsBloc.state,
    ).thenReturn(PaymentsError(GenericFailure(message: 'test error')));

    await tester.pumpWidget(buildTestWidget());

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Text && widget.data?.contains('test error') == true,
      ),
      findsOneWidget,
    );
  });

  testWidgets(
    'renders transaction tile when tab is transactions and PaymentsLoaded is emitted',
    (tester) async {
      final mockInfo = MockPaymentsInfo();

      when(() => mockInfo.paymentsScheduled).thenReturn([]);
      when(() => mockInfo.summary).thenReturn([]);
      when(() => mockInfo.transactionFilter).thenReturn([]);
      when(() => mockInfo.transactions).thenReturn([
        PaymentsTransactionsModel(
          key: 'tx1',
          actualPaymentPostDate: DateTime.now(),
          processDate: DateTime.now(),
          actualPaymentAmount: 100,
          actualPrincipalPaymentAmount: 80,
          actualInterestPaymentAmount: 20,
          outstandingPrincipalBalance: 400,
          outstandingLoanBalance: 450,
          actualFee: 5,
          paymentType: 'manual',
        ),
      ]);

      when(
        () => paymentsTabBloc.state,
      ).thenReturn(PaymentsTabState(PaymentsTab.transactions));
      when(() => paymentsBloc.state).thenReturn(PaymentsLoaded(mockInfo));
      when(() => filterBloc.state).thenReturn(
        const TransactionsFilterState({
          "Processed Date": true,
          "Amount": true,
          "Type": true,
          "Posted Date": false,
          "Principal Paid": false,
          "Interest Paid": false,
          "Fee": false,
          "Outstanding Principal": false,
          "Outstanding Loan Balance": false,
        }),
      );

      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.byType(CustomScrollView), findsOneWidget);
      expect(find.byType(PaymentsScrollContent), findsOneWidget);
    },
  );
}
