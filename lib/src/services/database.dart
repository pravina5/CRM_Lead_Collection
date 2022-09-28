// TODO Implement this library.

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfo(userData,id) async {
    FirebaseFirestore.instance.collection("users").doc(id).set(userData).catchError((e){print(e.toString());});
  }

  getUserInfo(String email) async {
    return FirebaseFirestore.instance.collection("users").where("email", isEqualTo: email).get().catchError((e) {
      print(e.toString());
    });
  }
  addLead(leadData) async{
        FirebaseFirestore.instance.collection("leads").add(leadData).catchError((e){print(e.toString());});
  }

  getuserLeads(uid)  async{
    return await  FirebaseFirestore.instance.collection("leads").where('uid' ,isEqualTo: uid).get().catchError((e) {
      print(e.toString());
    });

  }
  
}
