import 'package:crm_project/src/screens/login.dart';
import 'package:crm_project/src/screens/signup.dart';
import 'package:flutter/material.dart';
import 'package:crm_project/src/screens/login.dart';


class Authenticate extends StatefulWidget {
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return Login(toggleView);
    } else {
      return Signup(toggleView);
    }
  }
}
