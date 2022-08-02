import 'package:crm_project/src/helper/authenticate.dart';
import 'package:crm_project/src/helper/helperfunctions.dart';
import 'package:crm_project/src/screens/add_lead.dart';
import 'package:crm_project/src/screens/view_leads.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:crm_project/src/screens/login.dart';

class Home extends StatelessWidget {
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        //title: const Text('AppBar Demo'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              HelperFunctions.saveUserLoggedInSharedPreference(false);
              auth.signOut();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Authenticate()));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AddLead()));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(35),
                primary: const Color(0xff4c505b), // <-- Button color
              ),
              child: const Icon(
                Icons.person_add,
                color: Colors.white,
                size: 80,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Add contacts"),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ViewLead()));
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(35),
                primary: const Color(0xff4c505b), // <-- Button color
              ),
              child: const Icon(
                Icons.contact_page,
                color: Colors.white,
                size: 80,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("View contacts"),
          ],
        ),
      ),
    );
  }
}
