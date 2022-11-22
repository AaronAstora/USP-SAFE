// ignore_for_file: unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usp_response_app/screens/location.dart';

import 'package:geocoding/geocoding.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/services/reportservice.dart';

import 'package:intl/intl.dart';

class ReportIncidents extends StatefulWidget {
  const ReportIncidents({super.key});

  @override
  State<ReportIncidents> createState() => _ReportIncidentsState();
}

class _ReportIncidentsState extends State<ReportIncidents> {
  String locality = '';
  String street = '';

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location permissions are permantly denied. we cannot request permissions.");
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            "Location permissions are denied (actual value: $permission).");
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    DateTime now = DateTime.now();
    String? address;

    String formattedDate = DateFormat('hh:mm a \n EEE d MMM').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Incidents"),
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
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 300.00,
                height: 100.00,
                decoration: BoxDecoration(
                  color: Colors.white,
                  image: const DecorationImage(
                      image: AssetImage('assets/report.png')),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 90.00)),
          //reuqest help, fire and medical
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  //Request Help
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox(
                          'Request Help', context, formattedDate, address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.orange), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
              SizedBox(
                  //fire
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox('Fire', context, formattedDate, address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.red), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.local_fire_department,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
              SizedBox(
                  //medical emergency
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox('Medical Emergency', context, formattedDate,
                          address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.lightBlue), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.medical_services,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Request\nHelp",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Fire",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Medical\nEmergency",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  //suspicious person
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox('Suspicious Person', context, formattedDate,
                          address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.deepOrange), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
              SizedBox(
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox(
                          'Mugging', context, formattedDate, address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.grey), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.dangerous,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
              SizedBox(
                  // bodily injury
                  width: 100.00,
                  height: 80.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      try {
                        Position pos = await _determinePosition();
                        List<Placemark> placemarks =
                            await placemarkFromCoordinates(
                                pos.latitude, pos.longitude);

                        setState(() {
                          address =
                              '${placemarks[0].locality}, ${placemarks[0].name}';
                        });
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      if (!mounted) return;
                      showdialogbox(
                          'Bodily Injury', context, formattedDate, address!);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.blue), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.personal_injury,
                      color: Colors.white,
                      size: 40.00,
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 10.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Suspicious\nPerson",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Mugging",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                width: 100.00,
                height: 80.00,
                child: Text("Bodily\nInjury",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ],
      )),
    );
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ));
}

Future createUser(Report user) async {
  final docUser = FirebaseFirestore.instance.collection('Incidents').doc();
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

void showdialogbox(String incident, context, String time, String location) {
  showDialog(
      context: context,
      builder: (_) => Dialog(
            child: Container(
              width: 300,
              height: 170,
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 14.00)),
                  Row(
                    children: const [
                      SizedBox(
                        width: 180,
                        height: 30,
                        child: Text(
                          '      Confirm Report',
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 14.00)),
                  Row(
                    children: const [
                      SizedBox(
                        width: 280,
                        height: 40,
                        child: Text(
                          "       Are you sure you want to send \n       an incident report?",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24.00)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(fontSize: 16),
                          )),
                      TextButton(
                          onPressed: () {
                            final firebaseUser =
                                FirebaseAuth.instance.currentUser!;
                            final report = Report(
                                Location: location,
                                Id: firebaseUser.uid,
                                Time: time,
                                Type: incident);
                            createUser(report);

                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/image');
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ));
}
