import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learning/domain/auth/auth_failure.dart';
import 'package:learning/domain/auth/i_auth_facade.dart';
import 'package:learning/domain/auth/value_object.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.iniitial()) {
    on<SignInFormEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SignInFormEvent event, Emitter<SignInFormState> emit) {
    // ignore: void_checks
    return event.map(emailChanged: (event) async {
      state.copyWith(
          emailAddress: EmailAddress(event.emailStr),
          authFailureOrSucessOption: none());
    }, passwordChanged: (event) async {
      state.copyWith(
          password: Password(event.passwordStr),
          authFailureOrSucessOption: none());
    }, registerWithEmailAndPasswordPressed: (event) async {
      _performActionOnAuthFacadeWithEmailAndPassword(
        _authFacade.registerWithEmailAndPassword,
      );
    }, signInWithEmailAndPasswordPressed: (event) async {
      _performActionOnAuthFacadeWithEmailAndPassword(
        _authFacade.signInWithEmailAndPassword,
      );
    }, signInWithGooglePressed: (event) async {
      state.copyWith(isSubmitting: true, authFailureOrSucessOption: none());
      final failureOrSuccess = await _authFacade.signInWithGoogle();
      state.copyWith(
          isSubmitting: false,
          authFailureOrSucessOption: some(failureOrSuccess));
    });
  }

  Stream<SignInFormState> _performActionOnAuthFacadeWithEmailAndPassword(
    Future<Either<AuthFailure, Unit>> Function({
      required EmailAddress emailAddress,
      required Password password,
    })
        forwardedCall,
  ) async* {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    late Either<AuthFailure, Unit> failureOrSuccess;
    if (isEmailValid && isPasswordValid) {
      state.copyWith(authFailureOrSucessOption: none(), isSubmitting: false);

      failureOrSuccess = await forwardedCall(
          emailAddress: state.emailAddress, password: state.password);
      state.copyWith(
          authFailureOrSucessOption: some(failureOrSuccess),
          isSubmitting: false);
    }

    state.copyWith(
        isSubmitting: false,
        showErrorMessages: true,
        authFailureOrSucessOption: optionOf(failureOrSuccess));
  }
}
