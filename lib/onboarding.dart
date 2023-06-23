import 'package:djossi_mobile_app/Register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('djossi',
              style: GoogleFonts.poppins(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xff426CEA))),
          const SizedBox(
            height: 9,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50,right: 40),
            child: Text(
                'Nous facilitions la mise en relation entre les clients et les prestataires de services dans différents domaines.',
                style: GoogleFonts.poppins(fontSize: 15)),
          ),
            const SizedBox(
            height: 400,
          ),
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) => Scaffold(),
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xff426CEA),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(13.0),
                                bottomLeft: Radius.circular(13.0)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                'Connexion',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap:  () {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                 builder: (BuildContext context) => const Register(),
                              ));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xff426CEA),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(13.0),
                                  bottomRight: Radius.circular(13.0)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Center(
                                child: Text(
                                  'S\'inscrire',
                                  style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
