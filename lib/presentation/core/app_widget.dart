import 'package:flutter/material.dart';
import 'package:learning/presentation/sign_in/sign_in_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notes',
        theme: ThemeData.light().copyWith(
            primaryColor: Colors.green[800],
            colorScheme:
                ColorScheme.fromSwatch().copyWith(secondary: Colors.blueAccent),
            inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8)))),
        home: SignInPage());
  }
}
