import 'package:equatable/equatable.dart';

enum InfraCode { unexpected }

class InfraError extends Equatable {
  final InfraCode code;
  final dynamic error;

  const InfraError(this.code, {this.error});

  @override
  List<Object?> get props => [code, error];
}
