//import 'dart:html';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:crm_project/src/helper/authenticate.dart';
import 'package:crm_project/src/helper/helperfunctions.dart';
import 'package:crm_project/src/screens/home.dart';
import 'package:crm_project/src/screens/login.dart';
import 'package:flutter/material.dart';


class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
    bool? userIsLoggedIn;
 void initState() {
    getLoggedInState();
    super.initState();
  }

    getLoggedInState() async {
    await HelperFunctions.getUserLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
      });

    });
  }
 

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CRM App",
      theme: ThemeData(
        colorScheme:  ColorScheme.fromSwatch(
          accentColor: Colors.orange,
          primarySwatch: Colors.blue
        )
      ),
       home: AnimatedSplashScreen(
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 400,
        nextScreen: userIsLoggedIn != null?( userIsLoggedIn != null && userIsLoggedIn! )? Home()
                : Authenticate()
            : Container(
                child: Center(
                  child: Authenticate(),
                ),
              ),
              
        splash: Image.asset("assets/images/start.png"),
      ),
        debugShowCheckedModeBanner: false,
    );
  }
}
