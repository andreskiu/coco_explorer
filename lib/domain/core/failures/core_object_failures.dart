import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures.dart';

class CoreFailure extends Failure<CoreUseCaseProblems, CoreFieldProblems>
    with EquatableMixin {
  final CoreFields? field;
  final CoreUseCases? useCase;

  @override
  Problem<CoreUseCaseProblems, CoreFieldProblems> problem;

  CoreFailure._({
    required this.problem,
    this.field,
    this.useCase,
  }) : super(
          problem: problem,
        );

  @override
  List<Object?> get props => [
        field,
        useCase,
        problem,
      ];

  factory CoreFailure.usecase(CoreUseCaseProblems error, CoreUseCases useCase) {
    return CoreFailure._(
      useCase: useCase,
      problem: Problem(
        type: ProblemTypes.Field,
        error: Left(error),
      ),
    );
  }

  factory CoreFailure.field(CoreFieldProblems error, CoreFields field) {
    return CoreFailure._(
      field: field,
      problem: Problem(
        type: ProblemTypes.Field,
        error: Right(error),
      ),
    );
  }

  @override
  ErrorContent getError() {
    String _msg = "";
    late CoreUseCaseProblems _useCaseError;
    late CoreFieldProblems _fieldError;

    problem.error.fold((useCaseError) {
      _useCaseError = useCaseError;
    }, (fieldError) {
      _fieldError = fieldError;
    });

    const _fieldBase = "core.fields.";

    switch (problem.type) {
      case ProblemTypes.UseCase:
        switch (useCase) {
          default:
            switch (_useCaseError) {
              default:
                break;
            }
            break;
        }
        break;
      case ProblemTypes.Field:
        switch (field) {
          case CoreFields.Email:
            switch (_fieldError) {
              case CoreFieldProblems.Empty:
                _msg = _fieldBase + "email.errors.empty";
                break;
              case CoreFieldProblems.InvalidValue:
                _msg = _fieldBase + "email.errors.invalid";
                break;
            }
            break;
          case CoreFields.Phone:
            switch (_fieldError) {
              case CoreFieldProblems.Empty:
                _msg = _fieldBase + "phone.errors.empty";
                break;
              case CoreFieldProblems.InvalidValue:
                _msg = _fieldBase + "phone.errors.invalid";
                break;
            }
            break;
          default:
            break;
        }
        break;
    }
    return ErrorContent(message: _msg);
  }
}

enum CoreFields { Email, Phone }
enum CoreUseCases { None }

enum CoreUseCaseProblems {
  InvalidParams,
  ServerError,
}
enum CoreFieldProblems {
  Empty,
  InvalidValue,
}
