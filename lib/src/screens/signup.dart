import 'package:flutter/material.dart';
import 'package:crm_project/src/services/auth.dart';
import 'package:crm_project/src/services/database.dart';
import 'home.dart';
import 'package:crm_project/src//helper/helperfunctions.dart';

class Signup extends StatefulWidget {
  final Function toggleView;

  const Signup(this.toggleView);

  @override
  // ignore: library_private_types_in_public_api
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {

  bool isloading = false;

  AuthMethods authMethods = AuthMethods();
  DatabaseMethods databaseMethods = DatabaseMethods();

  final formKey = GlobalKey<FormState>();
  TextEditingController unameTextEdit = TextEditingController();
  TextEditingController emailTextEdit = TextEditingController();
  TextEditingController passwordTextEdit = TextEditingController();
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

    return Container(
      decoration: const BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/Register1.jpeg'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Signup"),
        ),
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

                                  ///fillColor: Colors.grey.shade100,
                                  ///filled: true,
                                  hintText: ("username"),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                            const SizedBox(
                              height: 30,
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
                                decoration: InputDecoration(
                                    hintText: ("email"),

                                    ///fillColor: Colors.grey.shade100,
                                    ///filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            const SizedBox(
                              height: 30,
                            ),
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

                                  ///fillColor: Colors.grey.shade100,
                                  ///filled: true,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ]),
                        ),
                        SizedBox(
                          height: 30,
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
      )
      );
  } 
}                  
