import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure<T, R> {
  ErrorContent getError();
  Problem<T, R> problem;

  Failure({
    required this.problem,
  });
}

class Problem<T, R> {
  Problem({
    required this.error,
    required this.type,
  });
  Either<T, R> error;
  ProblemTypes type;
}

enum ProblemTypes { UseCase, Field }

class ErrorContent extends Equatable {
  final String message;
  final int errorCode;

  const ErrorContent({
    this.message = "",
    this.errorCode = 0,
  });

  @override
  List<Object> get props => [
        message,
        errorCode,
      ];
}
