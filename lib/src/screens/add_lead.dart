import 'package:crm_project/src/helper/helperfunctions.dart';
import 'package:crm_project/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AddLead extends StatefulWidget {
  const AddLead({Key? key}) : super(key: key);

  @override
  State<AddLead> createState() => _AddLeadState();
}

class _AddLeadState extends State<AddLead> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  bool isloading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController cnameTextEdit = new TextEditingController();
  TextEditingController cemailTextEdit = new TextEditingController();
  TextEditingController cphoneTextEdit = new TextEditingController();
  String? uid;
  add_lead() async {
    if (formKey.currentState!.validate()) {
      print("inside if");

      await HelperFunctions.getUserIDSharedPreference().then((value) {
        setState(() {
          uid = value;
        });
      });
      print("inside if 2");

      Map<String, String> leadData = {
        "cname": cnameTextEdit.text,
        "cemail": cemailTextEdit.text,
        "uid": uid ?? "",
        "cphone": cphoneTextEdit.text
      };
      databaseMethods.addLead(leadData);
      print("inside if 3");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add lead"),
        leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back)),
      ),
      body: isloading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
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
                              controller: cnameTextEdit,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(hintText: ("name"))),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: cemailTextEdit,
                            decoration: InputDecoration(
                              hintText: ("email"),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: cphoneTextEdit,
                            decoration: InputDecoration(
                              hintText: ("phone"),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                        child: Text("Save and Add more"),
                        onPressed: () async {
                          await add_lead();
                          print("onpress");

                          cnameTextEdit.clear();
                          cemailTextEdit.clear();
                          cphoneTextEdit.clear();
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      ElevatedButton(
                        child: Text("Save and Back"),
                        onPressed: () {
                          add_lead();
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
