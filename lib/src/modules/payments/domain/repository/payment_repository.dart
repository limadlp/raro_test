import 'package:base_project/src/core/core.dart';
import 'package:base_project/src/modules/payments/domain/domain.dart';
import 'package:dartz/dartz.dart';

abstract class PaymentsRepository {
  Future<Either<Failure, PaymentsInfoEntity>> getPayments();
}
