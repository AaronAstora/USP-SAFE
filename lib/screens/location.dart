import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final tempImage = File(image.path);
      setState(() {
        this.image = tempImage;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Future upload() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    String pathname = basename(image!.path);
    final path = 'files/report/${firebaseUser.uid}/$pathname';
    final file = File(image!.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    ref.putFile(file);
  }

  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('hh:mm a \n EEE d MMM').format(now);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Attach any optional image"),
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
            const Padding(padding: EdgeInsets.only(bottom: 20.00)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 30,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 300,
                  height: 200,
                  child: image != null
                      ? Image.file(image!)
                      : Image.asset('assets/empty.jpg'),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40.00)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    label: Text("Gallery"),
                    icon: const Icon(
                      Icons.image,
                      color: Colors.white,
                      size: 40.00,
                    ),
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 15.00)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  width: 170,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    label: Text("Camera"),
                    icon: const Icon(
                      Icons.photo_camera,
                      color: Colors.white,
                      size: 40.00,
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(bottom: 15.00)),
            SizedBox(
              height: 50,
              width: 170,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    image = null;
                  });
                },
                label: const Text("Delete Image"),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40.00,
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40.00)),
            SizedBox(
              width: 300.00,
              height: 50.00,
              child: ElevatedButton(
                onPressed: () async {
                  if (image != null) {
                    upload();
                    showSnackBar(context, 'Your image has been uploaded');
                    Navigator.pushNamed(context, '/home');
                  } else {
                    showSnackBar(context, 'Please select an image to upload');
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  "Submit",
                  style: GoogleFonts.roboto(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 25.00)),
            SizedBox(
              width: 300.00,
              height: 50.00,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text("Cancel",
                    style:
                        GoogleFonts.roboto(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
