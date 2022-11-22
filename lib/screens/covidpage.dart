import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CovidPage extends StatelessWidget {
  const CovidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Covid Information"),
          centerTitle: true,
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(bottom: 40)),
              Row(
                children: [
                  SizedBox(
                      width: 200.00,
                      height: 40.00,
                      child: Text("  Symptoms of Covid-19",
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w700)))
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage('assets/headache.png')),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage('assets/fever.png')),
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
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: const DecorationImage(
                          image: AssetImage('assets/caugh.png')),
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
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Text("Headache",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Text("Fever",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    height: 50,
                    width: 100,
                    child: Text("Cough",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black)),
                  )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                      width: 200.00,
                      height: 40.00,
                      child: Text("  Prevention",
                          style: GoogleFonts.roboto(
                              fontSize: 16, fontWeight: FontWeight.w700)))
                ],
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 140,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/wash_hands.png'),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      Container(
                          height: 140,
                          width: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                height: 20,
                                width: 130,
                                child: Text(
                                  "Wash Your Hands",
                                  style: GoogleFonts.lobster(fontSize: 16),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Container(
                                height: 80,
                                width: 240,
                                child: Text(
                                  "Wash hands often with soap and water for at least 20 seconds to avoid spreading the virus to others",
                                  style: GoogleFonts.lato(fontSize: 16),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 15)),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 140,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          height: 140,
                          width: 140,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage('assets/wear_mask.png'),
                            fit: BoxFit.fill,
                          )),
                        ),
                      ),
                      Container(
                          height: 140,
                          width: 240,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 5)),
                              Container(
                                height: 20,
                                width: 130,
                                child: Text(
                                  "Wear Mask",
                                  style: GoogleFonts.lobster(fontSize: 16),
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Container(
                                height: 80,
                                width: 240,
                                child: Text(
                                  "Wearing a face mask helps protect you and others by reducing the chance of spreading COVID-19",
                                  style: GoogleFonts.lato(fontSize: 16),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
