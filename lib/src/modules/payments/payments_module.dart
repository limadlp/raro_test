import 'package:base_project/src/modules/payments/data/data.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:base_project/src/modules/payments/infra/datasource/datasource.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/payments_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/bloc/transactions_filter_bloc.dart';
import 'package:base_project/src/modules/payments/presentation/page/payments_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PaymentsModule extends Module {
  @override
  void binds(i) {
    i.addSingleton<PaymentsDataSource>(PaymentsDatasourceImpl.new);
    i.addSingleton<PaymentsRepository>(PaymentsRepositoryImpl.new);
    i.addSingleton<GetPaymentsUseCase>(GetPaymentsUseCase.new);
    i.addSingleton<PaymentsBloc>(PaymentsBloc.new);
    i.addSingleton<TransactionsFilterBloc>(TransactionsFilterBloc.new);
  }

  @override
  void routes(r) {
    r.child(Modular.initialRoute, child: (context) => const PaymentsPage());
  }
}
