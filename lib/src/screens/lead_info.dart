import 'package:crm_project/src/app.dart';
import 'package:crm_project/src/models/lead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LeadInfo extends StatelessWidget {
  LeadInfo({super.key, required this.lead});

  // Declare a field that holds the Todo.
  Lead lead;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${lead.cname}"),
      ),
    );
  }
}