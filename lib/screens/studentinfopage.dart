import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:usp_response_app/services/databaseservice.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class StudentInformation extends StatefulWidget {
  const StudentInformation({super.key});

  @override
  State<StudentInformation> createState() => _StudentInformationState();
}

class _StudentInformationState extends State<StudentInformation> {
  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    return Scaffold(

        //backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: const Text("User Information"),
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
        body: FutureBuilder<UserList?>(
          future: readUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = snapshot.data;

              return user == null
                  ? const Center(child: Text("no user"))
                  : buildUser(user, context);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}

Stream<List<UserList>> readUsers() =>
    FirebaseFirestore.instance.collection('Users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => UserList.fromJson(doc.data())).toList());

Future<UserList?> readUser() async {
  final firebaseUser = await FirebaseAuth.instance.currentUser!;

  final docUser =
      FirebaseFirestore.instance.collection('Users').doc(firebaseUser.uid);
  final snapshot = await docUser.get();

  if (snapshot.exists) {
    return UserList.fromJson(snapshot.data()!);
  }
  return null;
}

Widget buildUser(UserList user, context) => Column(
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 40.00)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: Image.asset('assets/person.png'),
            )
          ],
        ),
        Expanded(
            child: ListView(
          padding: const EdgeInsets.all(20.00),
          children: ListTile.divideTiles(context: context, tiles: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(user.Name),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(user.Email),
            ),
            ListTile(
              leading: Icon(Icons.place),
              title: Text(user.Campus),
            ),
            ListTile(
              leading: Icon(Icons.source),
              title: Text(user.Role),
            ),
          ]).toList(),
        ))
      ],
    );
