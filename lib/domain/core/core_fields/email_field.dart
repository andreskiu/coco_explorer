import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/core/failures/core_object_failures.dart';

import '../value_objects.dart';

class EmailField extends ValueObject<String> {
  factory EmailField(
    String? input, {
    bool mandatory = false,
  }) {
    return EmailField._(
        value: validateEmailAddress(
      input,
      mandatory: mandatory,
    ));
  }

  EmailField._({
    required this.value,
  });

  @override
  final Either<CoreFailure, String> value;
}

Either<CoreFailure, String> validateEmailAddress(
  String? input, {
  bool mandatory = false,
}) {
  const field = CoreFields.Email;
  if (mandatory && (input == null || input.isEmpty)) {
    return Left(CoreFailure.field(CoreFieldProblems.Empty, field));
  }
  const emailRegex =
      r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
  if (RegExp(emailRegex).hasMatch(input!)) {
    return Right(input);
  } else {
    return Left(CoreFailure.field(CoreFieldProblems.InvalidValue, field));
  }
}
