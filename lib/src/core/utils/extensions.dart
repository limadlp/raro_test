import 'package:dartz/dartz.dart';

extension EitherExt<L, R> on Either<L, R> {
  R asRight() => (this as Right).value;
}
