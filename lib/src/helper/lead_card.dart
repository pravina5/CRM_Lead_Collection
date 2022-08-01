import 'package:crm_project/src/models/lead.dart';
import 'package:crm_project/src/screens/lead_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LeadCard extends StatelessWidget {
  //const LeadCard({Key? key, required this.lead}) : super(key: key);
  
  final Lead lead;
  LeadCard(this.lead);

  @override
  Widget build(BuildContext context) {
    return Container(
       
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder: (context) =>LeadInfo(lead: lead)));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Padding(padding: const EdgeInsets.only(bottom:10),
              child: Text("${lead.cname}"))
            ],),
          ),
        ),
      ),
    );
  }
}