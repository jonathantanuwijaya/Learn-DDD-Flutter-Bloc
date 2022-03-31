import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:learning/domain/auth/auth_failure.dart';
import 'package:learning/domain/auth/i_auth_facade.dart';
import 'package:learning/domain/auth/value_object.dart';

part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;
  SignInFormBloc(this._authFacade) : super(SignInFormState.iniitial()) {
    on<SignInFormEvent>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SignInFormEvent event, Emitter<SignInFormState> emit) async {
    await event.map(emailChanged: (event) async {
      emit(state.copyWith(
          emailAddress: EmailAddress(event.emailStr),
          authFailureOrSucessOption: none()));
    }, passwordChanged: (event) async {
      emit(state.copyWith(
          password: Password(event.passwordStr),
          authFailureOrSucessOption: none()));
    }, registerWithEmailAndPasswordPressed: (event) async {
      return _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.registerWithEmailAndPassword, emit);
    }, signInWithEmailAndPasswordPressed: (event) async {
      return _performActionOnAuthFacadeWithEmailAndPassword(
          _authFacade.signInWithEmailAndPassword, emit);
    }, signInWithGooglePressed: (event) async {
      emit(state.copyWith(
          isSubmitting: true, authFailureOrSucessOption: none()));
      final failureOrSuccess = await _authFacade.signInWithGoogle();
      emit(state.copyWith(
          isSubmitting: false,
          authFailureOrSucessOption: some(failureOrSuccess)));
    });
  }

  FutureOr<void> _performActionOnAuthFacadeWithEmailAndPassword(
      Future<Either<AuthFailure, Unit>> Function({
    required EmailAddress emailAddress,
    required Password password,
  })
          forwardedCall,
      Emitter<SignInFormState> emit) async {
    final isEmailValid = state.emailAddress.isValid();
    final isPasswordValid = state.password.isValid();
    Either<AuthFailure, Unit>? failureOrSuccess;
    if (isEmailValid && isPasswordValid) {
      emit(state.copyWith(
          authFailureOrSucessOption: none(),
          isSubmitting: true,
          showErrorMessages: AutovalidateMode.always));

      // failureOrSuccess = await forwardedCall(
      //     emailAddress: state.emailAddress, password: state.password);
      emit(state.copyWith(
          authFailureOrSucessOption: some(unit as Either<AuthFailure, Unit>),
          isSubmitting: false));
    }

    emit(state.copyWith(
        isSubmitting: false,
        showErrorMessages: AutovalidateMode.always,
        authFailureOrSucessOption: optionOf(failureOrSuccess)));
  }
}
