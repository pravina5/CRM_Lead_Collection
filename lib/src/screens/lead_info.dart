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
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(''), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text("${lead.cname}"),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.28,
                      right: 35,
                      left: 35),
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.redAccent,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                tooltip: 'Phone',
                                color: Colors.white,
                                onPressed: () {},
                                icon: const Icon(Icons.call),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                tooltip: 'Email',
                                color: Colors.white,
                                onPressed: () {},
                                icon: const Icon(Icons.email),
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                tooltip: 'Doc',
                                color: Colors.white,
                                onPressed: () {},
                                icon: const Icon(Icons.document_scanner),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: const Color(0xff4c505b),
                              child: IconButton(
                                tooltip: 'Text',
                                color: Colors.white,
                                onPressed: () {},
                                icon: const Icon(Icons.textsms),
                              ),
                            ),
                          ]),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
