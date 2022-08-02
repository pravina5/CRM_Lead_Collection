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

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: isloading
          ? const Center(
            child: CircularProgressIndicator(),
          )
          : SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 50,
                alignment: Alignment.center,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
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
                            decoration: const InputDecoration(
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
                              decoration: const InputDecoration(hintText: ("email"))),
                          TextFormField(
                            obscureText: true,
                            validator: (val) {
                              return val!.length < 6
                                  ? "Enter Password 6+ characters"
                                  : null;
                            },
                            controller: passwordTextEdit,
                            decoration: const InputDecoration(
                              hintText: ("password"),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          registerme();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(colors: [
                              Color(0xff0079FA),
                              Color(0xff2A75BC)
                            ]),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Text(
                            "Sign Up",
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?  ",
                          style: TextStyle(
                            fontSize: 18,
                          ),),
                          GestureDetector(
                            onTap: () {
                              widget.toggleView();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 17),
                              child: const Text(
                                "Login here!",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
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
