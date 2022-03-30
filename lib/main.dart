import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:learning/injection.dart';
import 'package:learning/presentation/core/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  configureInjection(Environment.prod);
  runApp(const AppWidget());
}


