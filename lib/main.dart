import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/screens/contactinfopage.dart';
import 'package:usp_response_app/screens/counselingpage.dart';
import 'package:usp_response_app/screens/covidpage.dart';
import 'package:usp_response_app/screens/emergencynotifpage.dart';
import 'package:usp_response_app/screens/faqpage.dart';
import 'package:usp_response_app/screens/location.dart';
import 'package:usp_response_app/screens/loginpage.dart';
import 'package:usp_response_app/screens/reportincidentspage.dart';
import 'package:usp_response_app/screens/studentinfopage.dart';
import 'package:usp_response_app/screens/wrapperpage.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'screens/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Authservice>(
          create: (_) => Authservice(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/wrapper',
        routes: {
          '/login': (context) => Login(),
          '/home': (context) => HomePage(),
          '/CovidPage': (context) => CovidPage(),
          '/wrapper': (context) => wrapper(),
          '/contactinfo': (context) => ContactInformation(),
          '/emergencynotif': (context) => EmergencyNotification(),
          '/reportincidents': (context) => ReportIncidents(),
          '/studentinfo': (context) => StudentInformation(),
          '/CounselingService': (context) => CounselingService(),
          '/faq': (context) => Faq(),
          '/image': (context) => Location()
        },
      ),
    );
  }
}
