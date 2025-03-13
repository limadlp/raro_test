import 'package:base_project/src/core/base/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String? errorDetail;
  final dynamic error;

  const Failure({required this.message, this.errorDetail, this.error});

  @override
  List<Object?> get props => [message, error, errorDetail];
}

class GenericFailure extends Failure {
  GenericFailure({String? message, super.errorDetail, super.error})
    : super(message: message ?? AppConstants.genericError001);
}
