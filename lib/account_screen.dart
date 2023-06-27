import 'package:djossi_mobile_app/Authentication.dart';
import 'package:djossi_mobile_app/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

class AccountScren extends StatefulWidget {
  const AccountScren({Key? key}) : super(key: key);

  @override
  State<AccountScren> createState() => _AccountScrenState();
}

class _AccountScrenState extends State<AccountScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: NetworkImage(
                    "${AppUrl.onlineSimpleUrl}/${prestataire.profileUrl}"),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text("${prestataire.nom} ${prestataire.prenom}",
                style: GoogleFonts.poppins(fontSize: 30, color: Colors.black)),
            ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (ctx) => const Onboarding())),
                child: Text("Déconnexion"))
          ],
        ),
      ),
    );
  }
}
