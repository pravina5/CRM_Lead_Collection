import 'package:flutter/material.dart';
import 'package:crm_project/src/services/auth.dart';
import 'package:crm_project/src/services/database.dart';
import 'home.dart';
import 'package:crm_project/src//helper/helperfunctions.dart';

class Signup extends StatefulWidget {
  final Function toggleView;

  Signup(this.toggleView);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isloading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController unameTextEdit = new TextEditingController();
  TextEditingController emailTextEdit = new TextEditingController();
  TextEditingController passwordTextEdit = new TextEditingController();
  registerme() {
    if (formKey.currentState!.validate()) {
      setState(() {
        isloading = true;
      });
      authMethods
          .signUpWithEmailAndPassword(emailTextEdit.text, passwordTextEdit.text)
          .then((val) {
        //print("$val");
        Map<String, String> userInfoMap = {
          "uname": unameTextEdit.text,
          "uemail": emailTextEdit.text,
          "uid": val.uid
        };
        print(emailTextEdit.text);
        HelperFunctions.saveUserEmailSharedPreference(emailTextEdit.text);
        HelperFunctions.saveUserNameSharedPreference(unameTextEdit.text);
        HelperFunctions.saveUserIDSharedPreference(val.uid);
        databaseMethods.addUserInfo(userInfoMap, val.uid);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Signup")),
      body: isloading
          ? Container(

              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.center,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Form(
                        key: formKey,
                        child: Column(children: [
                          TextFormField(
                            validator: (val) {
                              return (val == "" ||
                                      (val != null && val.length < 4))
                                  ? "Please provide username"
                                  : null;
                            },
                            controller: unameTextEdit,
                            decoration: InputDecoration(
                              hintText: ("username"),
                            ),
                          ),
                          TextFormField(
                              validator: (val) {
                                return RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(val!)
                                    ? null
                                    : "Enter correct email";
                              },
                              controller: emailTextEdit,
                              decoration: InputDecoration(hintText: ("email"))),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val!.length < 6
                                  ? "Enter Password 6+ characters"
                                  : null;
                            },
                            controller: passwordTextEdit,
                            decoration: InputDecoration(
                              hintText: ("password"),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerme();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xff0079FA),
                              const Color(0xff2A75BC)
                            ]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            "Sign Up",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?  "),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 17),
                              child: Text(
                                "Login here!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
