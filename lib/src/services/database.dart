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
  searchByName(String searchField) async {
    return await FirebaseFirestore.instance.collection("users").where('name', isEqualTo: searchField).get();
  }

  searchByInterest(String searchinterest) {
    return FirebaseFirestore.instance.collection("users").where('interest', isEqualTo: searchinterest).get();
  }

  addChatRoom(chatRoom, chatRoomId) {
    FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).set(chatRoom).catchError((e) {
      print(e);
    });
  }

  getChats(String chatRoomId) async {
    return FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").orderBy('time').snapshots();
  }

  // Future<void> addMessage(String chatRoomId, chatMessageData) {
  //   FirebaseFirestore.instance.collection("ChatRoom").doc(chatRoomId).collection("chats").add(chatMessageData).catchError((e) {
  //     print(e.toString());
  //   });
  // }

  getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance.collection("ChatRoom").where('user', arrayContains: itIsMyName).snapshots();
  }
}
