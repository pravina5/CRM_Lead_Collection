import 'package:flutter/material.dart';
import 'package:flutter_application_1/login.dart';
import 'package:flutter_application_1/register.dart';
import 'package:flutter_application_1/Crm_main_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      'login': (context) => MyLogin(),
      'register': (context) => MyRegister(),
      'crm': (context) => MyCRM(),
    },
  ));
}
