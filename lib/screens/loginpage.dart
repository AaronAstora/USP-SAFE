import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:usp_response_app/services/authservice.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String emailAddress = '', password = '', error = '';

  @override
  Widget build(BuildContext context) {
    final AuthService = Provider.of<Authservice>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(bottom: 120.00)),
          Row(
            //row 1
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 150.00,
                height: 100.00,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage('assets/usp2.png'),
                  fit: BoxFit.fill,
                )),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(bottom: 60.00)),
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 30.00)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300.00,
                    height: 50.00,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          emailAddress = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.email),
                        labelText: 'Email',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 30.00)),
              Row(
                //row 3
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300.00,
                    height: 50.00,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value.trim();
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Password',
                        contentPadding:
                            const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 80.00)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 300.00,
                    height: 50.00,
                    child: ElevatedButton(
                      onPressed: () async {
                        AuthService.signInWithEmailAndPassword(
                            emailAddress, password, context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue),
                      child: const Text(
                        "Sign in",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                      child: Text(
                    error,
                    style: const TextStyle(color: Colors.blue),
                  ))
                ],
              )
            ],
          ),
          // const Padding(padding: EdgeInsets.only(bottom: 180.00)),
        ],
      ),
    ));
  }
}

OutlineInputBorder myinputborder() {
  //return type is OutlineInputBorder
  return const OutlineInputBorder(
      //Outline border type for TextFeild
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 3,
      ));
}

OutlineInputBorder myfocusborder() {
  return const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.greenAccent,
        width: 3,
      ));
}
