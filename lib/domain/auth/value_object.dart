import 'package:dartz/dartz.dart';
import 'package:learning/core/value_object.dart';
import 'package:learning/core/failures.dart';
import 'package:learning/core/value_validators.dart';

class EmailAddress extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    assert(input != null);
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    assert(input != null);
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}


void showingInvalidEmail() {
  final emailAddress = EmailAddress('sadfas');

  String emailText =
      emailAddress.value.fold((left) => 'Failure Happened', (right) => right);

  String emailText2 =
      emailAddress.value.getOrElse(() => 'Some failure happened');
}