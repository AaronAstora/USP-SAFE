import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/services/authservice.dart';

class Faq extends StatefulWidget {
  const Faq({super.key});

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  final List<Step> _steps = getSteps();
  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Frequently Asked Questions"),
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
      body: SingleChildScrollView(
          child: Container(
        child: _renderSteps(),
      )),
    );
  }

  Widget _renderSteps() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _steps[index].isExpanded = !isExpanded;
        });
      },
      children: _steps.map<ExpansionPanel>((Step step) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                step.title,
                style: TextStyle(color: Colors.blue),
              ),
            );
          },
          body: ListTile(
            title: Text(step.body),
          ),
          isExpanded: step.isExpanded,
        );
      }).toList(),
    );
  }
}

class Step {
  Step(this.title, this.body, [this.isExpanded = false]);
  String title;
  String body;
  bool isExpanded;
}

List<Step> getSteps() {
  return [
    Step(
        'What is USP SAFE?',
        'USP SAFE is a mobile app that will help foster a more healthy learning environment'
            'by letting students and staff report any incidents and check emergency drill schedules and evacuation zones'),
    Step('Does USP SAFE require internet connection to send incident reports?',
        'Yes, USE SAFE will require internet connection to send any incident reports'),
    Step('Does USE SAFE require internet connection to use panic call?',
        'No, USP SAFE will not need internet connection for panic calls'),
    Step(
        'What impact will USP SAFE App have on my phone’s battery life?',
        'The USP SAFE app has been built to consume minimal battery while in operation,'
            'meaning that the app will have little to no impact on your everyday use.'),
    Step('How can you register for Drill participation?',
        'You can register for any drills by simply clicking on the corresponding checkbox'),
    Step(
        'How much of my mobile data or WIFI does the app use?',
        'Very low mobile data will be consumed while the app is running. Mobile data or WIFI is only required for'
            'sending incident reports and registering for drill participation'),
    Step(
        'What type of information is captured by the USP Emergency Response App?',
        'Type of incident reported, any images and location User participation for emergency drills'),
    Step(
        'How will the USP Database Administrative Team have access to my information?',
        'All information sent by the users will be stored on the Firestore Database to which only authorized staff'
            'will have access.'),
    Step(
        'What happens if I uninstall the USP Emergency Response App?',
        'If you uninstall the USP Emergency Response App, which can be done at any time, the application would'
            'be immediately be deleted from your mobile phone.')
  ];
}
