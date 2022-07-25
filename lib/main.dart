import 'package:crm_project/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,

  );
  // ignore: prefer_const_constructors
  runApp(App());
}
