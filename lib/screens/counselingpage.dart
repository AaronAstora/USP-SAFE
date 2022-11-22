import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_response_app/services/counselingservice.dart';

class CounselingService extends StatefulWidget {
  const CounselingService({super.key});

  @override
  State<CounselingService> createState() => _CounselingServiceState();
}

class _CounselingServiceState extends State<CounselingService> {
  List<String> listitems = [
    "Select Counselor",
    "Kumar",
    "Reddy",
    "Nitesh",
  ];
  String selectval = "Select Counselor";

  List<String> listitems2 = [
    "Select Time",
    "09:00am - 10:00am",
    "11:00am - 12:00pm",
    "02:00pm - 03:00pm",
  ];
  String selectval2 = "Select Time";

  List<String> listitems3 = [
    "Select Reason",
    "Personal",
    "Family Issues",
    "Cyberbullying",
    "Mental health",
  ];
  String selectval3 = "Select Reason";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counseling Service"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 200.00,
                  height: 30.00,
                  child: Text("  Counsellor",
                      style: GoogleFonts.lato(fontSize: 19))),
              SizedBox(
                width: 200.00,
                height: 50.00,
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  value: selectval,
                  onChanged: (value) {
                    setState(() {
                      selectval =
                          value.toString(); //change selectval to new value
                    });
                  },
                  items: listitems.map((itemone) {
                    return DropdownMenuItem(
                        value: itemone, child: Text(itemone));
                  }).toList(),
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 200.00,
                  height: 30.00,
                  child: Text("  Time", style: GoogleFonts.lato(fontSize: 19))),
              SizedBox(
                width: 200.00,
                height: 50.00,
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  value: selectval2,
                  onChanged: (value) {
                    setState(() {
                      selectval2 =
                          value.toString(); //change selectval to new value
                    });
                  },
                  items: listitems2.map((itemone) {
                    return DropdownMenuItem(
                        value: itemone, child: Text(itemone));
                  }).toList(),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 200.00,
                  height: 30.00,
                  child: Text("  Reason for Visit",
                      style: GoogleFonts.lato(fontSize: 19))),
              SizedBox(
                width: 200,
                height: 50,
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 16,
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  value: selectval3,
                  onChanged: (value) {
                    setState(() {
                      selectval3 =
                          value.toString(); //change selectval to new value
                    });
                  },
                  items: listitems3.map((itemone) {
                    return DropdownMenuItem(
                        value: itemone, child: Text(itemone));
                  }).toList(),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 180.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 300.00,
                height: 50.00,
                child: ElevatedButton(
                  onPressed: () async {
                    if (selectval == "Select Counselor" ||
                        selectval2 == "Select Time" ||
                        selectval3 == "Select Reason") {
                      showSnackBar(context,
                          'Please select all options before submitting');
                    } else {
                      final firebaseUser =
                          await FirebaseAuth.instance.currentUser!;
                      final report = Counseling(
                          Counsellor: selectval,
                          Time: selectval2,
                          Reason: selectval3);
                      createUser(report);
                      if (!mounted) return;
                      showSnackBar(context,
                          'Your request for counseling has been submitted');
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  child: Text("Submit"),
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}

Future createUser(Counseling user) async {
  final docUser = FirebaseFirestore.instance.collection('counselling').doc();
  final json = user.toJson();
  await docUser.set(json);
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
