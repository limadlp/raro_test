import 'package:equatable/equatable.dart';

// TODO: Use a entity já feita
class TransactionsFilterState extends Equatable {
  final Map<String, bool> options;

  const TransactionsFilterState(this.options);

  @override
  List<Object> get props => [options];
}
