import 'package:dartz/dartz.dart';
import 'package:learning/domain/auth/auth_failure.dart';
import 'package:learning/domain/auth/user.dart';
import 'value_object.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();

  Future<Option<User>> getSignedUser();
  Future<void> signOut();
}
