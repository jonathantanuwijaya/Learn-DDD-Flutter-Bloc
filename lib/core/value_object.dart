import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:learning/core/errors.dart';
import 'failures.dart';

@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure<T>, T> get value;

  // factory EmailAddress(String input) {
  //   assert(input != null);
  //   return EmailAddress._(validateEmailAddress(input));
  // }
  T getOrCrash() {
    return value.fold(
        (failure) => throw UnExpectedValueError(failure), (r) => r);
  }

//  const EmailAddress._(this.value);
  bool isValid() => value.isRight();

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value(value: $value)';
}
