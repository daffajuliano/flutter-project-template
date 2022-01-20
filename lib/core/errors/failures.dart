import 'package:equatable/equatable.dart';

/// Failures often used with dartz either for Failure result (Left result)
abstract class AppFailure extends Equatable {
  final String? message;

  const AppFailure({
    this.message,
  });

  @override
  List<Object?> get props => [message];
}

class Failure extends AppFailure {
  const Failure({String? message}) : super(message: message);

  @override
  List<Object?> get props => [message];
}
