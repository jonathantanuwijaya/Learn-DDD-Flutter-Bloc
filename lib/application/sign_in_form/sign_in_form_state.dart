part of 'sign_in_form_bloc.dart';

@freezed
class SignInFormState with _$SignInFormState {
  const factory SignInFormState({
    required EmailAddress emailAddress,
    required Password password,
    required bool isSubmitting,
    required AutovalidateMode showErrorMessages,
    required Option<Either<AuthFailure, Unit>> authFailureOrSucessOption,
  }) = _SignInFormState;

  factory SignInFormState.iniitial() => SignInFormState(
      emailAddress: EmailAddress(''),
      password: Password(''),
      isSubmitting: false,
      showErrorMessages: AutovalidateMode.disabled,
      authFailureOrSucessOption: none());
}
