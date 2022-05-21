import 'package:dartz/dartz.dart';
import 'package:flutter_base/domain/core/failures/core_object_failures.dart';

import '../value_objects.dart';

class PhoneNumber extends ValueObject<String> {
  factory PhoneNumber(String? input, {bool mandatory = false}) {
    return PhoneNumber._(
        value: validatePhoneNumber(input, mandatory: mandatory));
  }

  PhoneNumber._({
    required this.value,
  });

  @override
  final Either<CoreFailure, String> value;
}

Either<CoreFailure, String> validatePhoneNumber(
  String? input, {
  bool mandatory = false,
}) {
  final field = CoreFields.Phone;

  if (mandatory && (input == null || input.isEmpty)) {
    return Left(CoreFailure.field(CoreFieldProblems.Empty, field));
  }
  String inputWithoutSimbols = "";
  RegExp(r"(\d)").allMatches(input!).forEach((e) {
    inputWithoutSimbols = inputWithoutSimbols + (e.group(0) ?? "");
  });
  if (!mandatory && input.isEmpty) {
    return Right(inputWithoutSimbols);
  }

  // CHECK THE FOLLOWINGS FORMAT VALIDATIONS AND ADJUST TO FIT YOUR REQUIREMENTS

  // Only US numbers
  if (inputWithoutSimbols[0] != "1") {
    return Left(CoreFailure.field(CoreFieldProblems.InvalidValue, field));
  }
  // 11 AND 12 NUMBERS ALLOWED
  if (inputWithoutSimbols.length < 11 || inputWithoutSimbols.length > 12) {
    return Left(CoreFailure.field(CoreFieldProblems.InvalidValue, field));
  }

  return Right(inputWithoutSimbols);
}
