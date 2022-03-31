import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/application/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        listener: (context, state) {
      debugPrint('snackbar is called');
      state.authFailureOrSucessOption.fold(
          () {},
          (either) => either.fold((failure) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: const Text('Error Happened'),
                  action: SnackBarAction(
                    label: 'Action',
                    onPressed: () {},
                  ),
                ));
              }, (_) => {}));
    }, builder: (context, state) {
      return Form(
        key: _formKey,
        autovalidateMode: state.showErrorMessages,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              const Text('Notes DDD', textAlign: TextAlign.center),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email), labelText: 'Email'),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.emailChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .emailAddress
                    .value
                    .fold(
                        (l) => l.maybeMap(
                            invalidEmail: (_) => 'Invalid Email',
                            orElse: () => null),
                        (_) => null),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock), labelText: 'Password'),
                autocorrect: false,
                onChanged: (value) => context
                    .read<SignInFormBloc>()
                    .add(SignInFormEvent.passwordChanged(value)),
                validator: (_) => context
                    .read<SignInFormBloc>()
                    .state
                    .password
                    .value
                    .fold(
                        (l) => l.maybeMap(
                            shortPassword: (_) => 'Short Password',
                            orElse: () => null),
                        (_) => null),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .signInWithEmailAndPasswordPressed());
                          },
                          child: const Text('SIGN IN'))),
                  Expanded(
                      child: TextButton(
                          onPressed: () {
                            context.read<SignInFormBloc>().add(
                                const SignInFormEvent
                                    .registerWithEmailAndPasswordPressed());
                          },
                          child: const Text('REGISTER')))
                ],
              ),
              ElevatedButton(
                  onPressed: () {
                    context
                        .read<SignInFormBloc>()
                        .add(const SignInFormEvent.signInWithGooglePressed());
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
                  child: const Text(
                    'Sign In With Google',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  if(state.isSubmitting) ...[
                    const SizedBox(height: 8,),
                    const LinearProgressIndicator(value: null,)
                  ]
            ],
          ),          
        ),
      );
    });
  }
}
