import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning/application/auth_bloc.dart';
import 'package:learning/injection.dart';
import 'package:learning/presentation/sign_in/sign_in_page.dart';
import 'package:learning/presentation/splash/splash_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<AuthBloc>()..add(const AuthEvent.authCheckRequested()))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Notes',
          theme: ThemeData.light().copyWith(
              primaryColor: Colors.green[800],
              colorScheme: ColorScheme.fromSwatch()
                  .copyWith(secondary: Colors.blueAccent),
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)))),
          home: SplashPage()),
    );
  }
}
