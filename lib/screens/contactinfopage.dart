import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactInformation extends StatelessWidget {
  const ContactInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Contact Information"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 15)),
            Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 250,
                  child: Text(
                    "   Emergency Contacts",
                    style: GoogleFonts.roboto(
                        fontSize: 19, fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 50,
                  ),
                  onPressed: () async {
                    final url = Uri.parse('tel:+679 323 1444');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'could not launch';
                    }
                  }),
              title: Text('USP Call Centre number'),
              subtitle: const Text(
                ' Tel +(679) 323 1444',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isThreeLine: true,
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 50,
                  ),
                  onPressed: () async {
                    final url = Uri.parse('tel:+679 323 2211');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'could not launch';
                    }
                  }),
              title: Text('USP Security'),
              subtitle: Text(
                ' Tel (+679) 323 2211',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isThreeLine: true,
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 50,
                  ),
                  onPressed: () async {
                    final url = Uri.parse('tel:+679 323 2362');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'could not launch';
                    }
                  }),
              title: Text('USP Health and Wellness Centre'),
              subtitle: Text(
                ' Tel (+679) 323 2362',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isThreeLine: true,
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 50,
                  ),
                  onPressed: () async {
                    final url = Uri.parse('tel:+679 122');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'could not launch';
                    }
                  }),
              title: Text('Campus Emergency'),
              subtitle: Text(
                ' 122',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isThreeLine: true,
            ),
            ListTile(
              leading: IconButton(
                  icon: const Icon(
                    Icons.phone,
                    size: 50,
                  ),
                  onPressed: () async {
                    final url = Uri.parse('tel:+679 330 2584');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url);
                    } else {
                      throw 'could not launch';
                    }
                  }),
              title: Text('St John Ambulance, Suva City Area'),
              subtitle: Text(
                ' Tel (+679)330 2584',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
              isThreeLine: true,
            ),
          ],
        )));
  }
}
