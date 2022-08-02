

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crm_project/src/helper/helperfunctions.dart';
import 'package:crm_project/src/helper/lead_card.dart';
import 'package:crm_project/src/models/lead.dart';
import 'package:crm_project/src/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';


class ViewLead extends StatefulWidget {
  const ViewLead({Key? key}) : super(key: key);

  @override
  State<ViewLead> createState() => _ViewLeadState();
}

class _ViewLeadState extends State<ViewLead> {
  String? uid;
  List<Object> leads=[];
  DatabaseMethods databaseMethods = new DatabaseMethods();

Future fetchAllContact() async {
  await HelperFunctions.getUserIDSharedPreference().then((value) {
      setState(() {
        uid = value;
      });

    });
  print(uid);
  var data=await databaseMethods.getuserLeads(uid);

  setState(() {
    leads=List.from(data.docs.map((doc)=>Lead.fromSnapshot(doc)));
  });
   
  }
   @override
  void initState() {
    super.initState();
     
    
    fetchAllContact();

  }
  
  @override
  Widget build(BuildContext context) {
  return  Scaffold(
    appBar: AppBar(
      title: Text("Leads"),
    ),
    body: SafeArea(
      child: ListView.builder(
        itemCount: leads.length,
        itemBuilder: (context,index){
          return LeadCard(leads[index] as Lead);
        },
      ),
    ),
  );
  }
  }