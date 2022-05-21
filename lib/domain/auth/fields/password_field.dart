import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/auth/failures/auth_failures.dart';
import 'package:flutter_base/domain/core/utils/constants.dart';
import 'package:flutter_base/domain/core/utils/regular_expressions.dart';
import 'package:flutter_base/domain/core/value_objects.dart';

class PasswordField extends ValueObject<String> {
  factory PasswordField(
    String? input, {
    bool validateSecurity = false,
  }) {
    return PasswordField._(
        value: validatePassword(
      input,
      validateSecurity: validateSecurity,
    ));
  }

  PasswordField._({
    required this.value,
  });

  @override
  final Either<AuthFailure, String> value;
}

Either<AuthFailure, String> validatePassword(
  String? input, {
  bool validateSecurity = false,
}) {
  const field = AuthFields.Password;
  if (input == null || input.isEmpty) {
    return Left(AuthFailure.field(AuthFieldProblems.Empty, field));
  }

  if (validateSecurity) {
    if (input.length < MinPasswordLength) {
      return Left(AuthFailure.field(AuthFieldProblems.TooShort, field));
    }
    if (!RegExp(RegPattern.containsAtLeastOneLowerCaseLetter).hasMatch(input)) {
      return Left(AuthFailure.field(AuthFieldProblems.WithoutLowerCase, field));
    }
    if (!RegExp(RegPattern.containsAtLeastOneUpperCaseLetter).hasMatch(input)) {
      return Left(AuthFailure.field(AuthFieldProblems.WithoutUpperCase, field));
    }
    if (!RegExp(RegPattern.containsAtLeastThreeNumbers).hasMatch(input)) {
      return Left(AuthFailure.field(AuthFieldProblems.WithoutNumber, field));
    }
    if (!RegExp(RegPattern.containsAtLeastOneSymbol).hasMatch(input)) {
      return Left(AuthFailure.field(AuthFieldProblems.WithoutASymbol, field));
    }
    return Right(input);
  }
  return Right(input);
}
