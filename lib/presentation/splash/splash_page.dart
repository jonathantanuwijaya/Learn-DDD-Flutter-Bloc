import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/application/auth_bloc.dart';
import 'package:learning/presentation/sign_in/sign_in_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.map(
            initial: (_) {},
            authenticated: (_) {
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => SignInPage()));
              debugPrint('User Authenticated');
            },
            unauthenticated: (_) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignInPage()));
            });
      },
      child: const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
