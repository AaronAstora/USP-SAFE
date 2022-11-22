import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/screens/homepage.dart';
import 'package:usp_response_app/screens/loginpage.dart';
import 'package:usp_response_app/services/authservice.dart';
import 'package:usp_response_app/services/usermodel.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<Authservice>(context);
    return StreamBuilder<Users?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<Users?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final Users? user = snapshot.data;
            return user == null ? Login() : HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
