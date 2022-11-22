import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'package:usp_response_app/services/databaseservice.dart';
import 'package:usp_response_app/services/emergencyservices.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_response_app/screens/studentinfopage.dart';

class EmergencyNotification extends StatefulWidget {
  const EmergencyNotification({super.key});

  @override
  State<EmergencyNotification> createState() => _EmergencyNotificationState();
}

class _EmergencyNotificationState extends State<EmergencyNotification> {
  bool value = false, value2 = false, value3 = false;
  String name = '';
  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Emergency Drills"),
          centerTitle: true,
          backgroundColor: Colors.red,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () async {
                  await AuthService.signOut().then((res) {
                    Navigator.pushNamed(context, '/wrapper');
                  });
                },
                icon: Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 12.00)),
              Row(
                children: [
                  SizedBox(
                    height: 60,
                    width: 100,
                    child: Text('  Schedule',
                        style: GoogleFonts.roboto(
                            fontSize: 21, fontWeight: FontWeight.w700)),
                  )
                ],
              ),
              SizedBox(
                height: 230,
                width: double.infinity,
                child: StreamBuilder<List<Emergency>>(
                  stream: readDrills(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text("something went wrong! ${snapshot.error}");
                    } else if (snapshot.hasData) {
                      final drills = snapshot.data!;

                      return ListView(
                        children: drills.map(buildReport).toList(),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 40,
                    child: Text(
                      '  Registration',
                      style: GoogleFonts.roboto(
                          fontSize: 21, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 2.00)),
              SizedBox(
                height: 60,
                child: CheckboxListTile(
                    title: const Text("Fire Drill"),
                    value: value,
                    onChanged: (value) {
                      setState(() => this.value = value!);
                    }),
              ),
              SizedBox(
                height: 60,
                child: CheckboxListTile(
                    title: const Text("Tsunami Drill"),
                    value: value2,
                    onChanged: (value2) {
                      setState(() => this.value2 = value2!);
                    }),
              ),
              SizedBox(
                height: 60,
                child: CheckboxListTile(
                    title: const Text("Earthquake Drill"),
                    value: value3,
                    onChanged: (value3) {
                      setState(() => this.value3 = value3!);
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 200.00,
                    height: 50.00,
                    child: ElevatedButton(
                      onPressed: () async {
                        final firebaseUser =
                            await FirebaseAuth.instance.currentUser!;

                        final docUser = FirebaseFirestore.instance
                            .collection('Users')
                            .doc(firebaseUser.uid);
                        final snapshot = await docUser.get();

                        if (snapshot.exists) {
                          Map<String, dynamic>? data = snapshot.data();
                          name = data!['Name'];
                        }

                        if (value) {
                          FirebaseFirestore.instance
                              .collection('Drills')
                              .doc('fireDrill')
                              .update({
                            'Participants': FieldValue.arrayUnion([name])
                          });
                        }
                        if (value2) {
                          FirebaseFirestore.instance
                              .collection('Drills')
                              .doc('tsunamiDrill')
                              .update({
                            'Participants': FieldValue.arrayUnion([name])
                          });
                        }
                        if (value3) {
                          FirebaseFirestore.instance
                              .collection('Drills')
                              .doc('earthquakeDrill')
                              .update({
                            'Participants': FieldValue.arrayUnion([name])
                          });
                        }
                        if (value || value2 || value3) {
                          showSnackBar(context,
                              "You have successfully signed up for drill participation");
                        } else {
                          showSnackBar(context,
                              "Please select at least one drill for participation");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}

Widget buildReport(Emergency emergency) => ListTile(
      leading: Icon(Icons.emergency),
      title: Text(
        emergency.Drill,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(emergency.Date),
      trailing: Text(emergency.Time),
    );

Stream<List<Emergency>> readDrills() => FirebaseFirestore.instance
    .collection('Drills')
    .snapshots()
    .map((snapshot) =>
        snapshot.docs.map((doc) => Emergency.fromJson(doc.data())).toList());

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
