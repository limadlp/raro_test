import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:dartz/dartz.dart';

class GetPaymentsUseCase implements UseCase<PaymentsInfoEntity, NoParams> {
  final PaymentsRepository _repository;

  GetPaymentsUseCase(this._repository);

  @override
  Future<Either<Failure, PaymentsInfoEntity>> call([NoParams? params]) async {
    final result = await _repository.getPayments();

    if (result.isRight()) {
      final paymentsInfo = result.asRight();

      paymentsInfo.paymentsScheduled
        ..removeWhere((payment) => payment.paymentDate.isBefore(DateTime.now()))
        ..sort((a, b) => a.paymentDate.compareTo(b.paymentDate));

      return Right(paymentsInfo);
    } else {
      return result;
    }
  }
}
