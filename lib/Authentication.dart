import 'dart:convert';

import 'package:djossi_mobile_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:djossi_mobile_app/HomePage.dart';
import 'package:http/http.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController numberController = TextEditingController();
  TextEditingController passController = TextEditingController();

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black38,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
          ListView(
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 250, top: 20),
                child: Container(
                  height: 130,
                  width: 130,
                  // child: Image.asset(
                  //   'assets/icone mobile.png',
                  // ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Container(
                  child: Text(
                    'Content de vous ',
                    style: GoogleFonts.poppins(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    'revoir !',
                    style: GoogleFonts.poppins(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff426CEA)),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'Connectez-vous et developpez\nvotre activité.',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 50, left: 25, right: 25),
                  child: TextField(
                    controller: numberController,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.phone_android_sharp,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        labelText: 'Numéro de téléphone',
                        floatingLabelStyle: TextStyle(color: Color(0xff426CEA)),
                        prefixText: '+225  ',
                        hintText: '07 07 07 07 07',
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                        prefixStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 27),
                        labelStyle: TextStyle(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(.8)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20))),
                  )),
              Padding(
                  padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: TextField(
                    controller: passController,
                    obscureText: true,
                    style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                    keyboardType: TextInputType.phone,
                    maxLines: 1,
                    maxLength: 10,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.visibility,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        labelText: 'Mot de passe',
                        floatingLabelStyle: TextStyle(color: Color(0xff426CEA)),
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 22),
                        prefixStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 27),
                        labelStyle: TextStyle(
                            color:
                                Color.fromARGB(255, 0, 0, 0).withOpacity(.8)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color.fromARGB(255, 0, 0, 0)),
                            borderRadius: BorderRadius.circular(20))),
                  )),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: RichText(
              //       text: TextSpan(children: [
              //     // TextSpan(
              //     //     text: 'Nous vous envrons ',
              //     //     style: TextStyle(color: Colors.black)),
              //     TextSpan(
              //         text: 'Mot de passe oublié ? ',
              //         style: GoogleFonts.poppins(fontWeight:FontWeight.bold, color: Color(0xff426CEA), fontSize: 14 )),
              //     // TextSpan(
              //     //     text: 'sur le numero que vous avez etrer',
              //     //     style: TextStyle(color: Colors.black)),
              //   ])),
              // ),
              Padding(
                padding: const EdgeInsets.only(left: 100, right: 100, top: 30),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Color(0xff426CEA),
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: InkWell(
                      onTap: () async {
                        await connectUser(context);
                      },
                      child: Text(
                        'Se connecter',
                        style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<void> connectUser(context) async {
    setState(() {
      isLoading = true;
    });
    final data = {
      'phone_number': numberController.text,
      'password': passController.text
    };
    final jsonData = json.encode(data);
    try {
      final response = await post(Uri.parse(AppUrl.connexionPrestataire),
          headers: {'Content-Type': 'application/json'}, body: jsonData);

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        debugPrint("La requete a reussis, voici le contenu : $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription réussie'),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => const HomePage(),
        ));
      } else {
        var responseData = json.decode(response.body);
        debugPrint("Le corps de la requete est : $jsonData");
        debugPrint("La requete a echoue, voici le contenu : $responseData");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseData['data']),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
