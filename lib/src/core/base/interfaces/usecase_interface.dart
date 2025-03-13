import 'package:base_project/src/core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class DefaultBlocState<T> extends Equatable {
  final Failure? failure;
  final T? refreshEvent;

  const DefaultBlocState({this.failure, this.refreshEvent});

  bool get shouldRefresh => failure != null && refreshEvent != null;

  @override
  List<Object?> get props => [failure, refreshEvent];
}
