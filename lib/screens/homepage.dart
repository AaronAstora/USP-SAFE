import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/authservice.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("USP SAFE"),
        centerTitle: true,
        backgroundColor: Colors.red,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await AuthService.signOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: createBody(context),
    );
  }
}

Widget createBody(context) => SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            //row 1
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/studentinfo');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.blue), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.people,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/reportincidents');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.red), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.report,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  ))
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                child: Text("User Information",
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                child: Text("Report Incidents",
                    style: TextStyle(color: Colors.black)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            //row 2
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/emergencynotif');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.orange), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.crisis_alert,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/contactinfo');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.green), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.contact_support,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  ))
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                child: Text("Emergency Notification",
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                child: Text("Contact Information",
                    style: TextStyle(color: Colors.black)),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            //row 3
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/CovidPage');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.blueAccent), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.coronavirus,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/CounselingService');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.purpleAccent), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.support,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                child: Text("Coronavirus Information",
                    style: TextStyle(color: Colors.black)),
              ),
              SizedBox(
                child: Text("Counseling Service",
                    style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = Uri.parse('tel:+679 323 1444');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        throw 'could not launch';
                      }
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.yellow), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
              SizedBox(
                  width: 150.00,
                  height: 100.00,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/faq');
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.blueGrey), // <-- Button color
                    ),
                    child: const Icon(
                      Icons.live_help,
                      color: Colors.white,
                      size: 50.00,
                    ),
                  )),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 5.00)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(
                width: 150,
                child: Center(
                    child: Text("Panic Call",
                        style: TextStyle(color: Colors.black))),
              ),
              SizedBox(
                width: 150,
                child: Center(
                    child: Text("FAQ", style: TextStyle(color: Colors.black))),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 120.00)),
          SizedBox(
            width: 200,
            height: 100,
            child: Image.asset('assets/USP-1-1.png'),
          )
        ],
      ),
    );
