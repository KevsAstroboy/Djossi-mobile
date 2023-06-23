import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int currentStep = 0;
  String services = '1';
  DateTime selectedDate = DateTime.now();
  TextEditingController nom_prestataire = TextEditingController();
  TextEditingController prenom_prestataire = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone_number = TextEditingController();
  TextEditingController numero_cni = TextEditingController();
  TextEditingController biographie = TextEditingController();
  String ville = 'ABIDJAN';
  String commune = 'COCODY';
  TextEditingController quartier = TextEditingController();
  TextEditingController cite = TextEditingController();
  TextEditingController numero_residence = TextEditingController();
  String? photo_prestataire;
  String? photo_piece_recto;
  String? photo_piece_verso;

  continueStep() async {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
      debugPrint(currentStep.toString());
    } else if (currentStep >= 2) {
      var data = {
        'nom_prestataire': nom_prestataire.text,
        'prenom_prestataire': prenom_prestataire.text,
        'services': services,
        'username': username.text,
        'password': password.text,
        'phone_number': phone_number.text,
        'numero_cni': numero_cni.text,
        'biographie': biographie.text,
        'ville': ville,
        'commune': commune,
        'quartier': quartier.text,
        'cite': cite.text,
        'numero_residence': numero_residence.text,
        'photo_prestataire': photo_prestataire,
        'photo_piece_recto': photo_piece_recto,
        'photo_piece_verso': photo_piece_verso,
      };

      // Convertir l'objet Map en JSON
      var jsonData = json.encode(data);

      // Envoyer la requête POST
      var response = await http.post(
        Uri.parse(
            'http://127.0.0.1:8000/api/prestataire/'), // Remplacez l'URL par votre endpoint
        headers: {'Content-Type': 'application/json'},
        body: jsonData,
      );

      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        // La requête a réussi
        var responseData = json.decode(response.body);
        print(responseData);
        // Traitez la réponse ici
      } else {
        // La requête a échoué
        var responseData = json.decode(response.body);
        print(responseData);
        print('Request failed with status: ${response.statusCode}');
      }
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Future<void> selectPhotoPrestataire() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_prestataire = pickedFile.path;
      });
    }
  }

  Future<void> selectPhotoPieceRecto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_piece_recto = pickedFile.path;
      });
    }
  }

  Future<void> selectPhotoPieceVerso() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_piece_verso = pickedFile.path;
      });
    }
  }

  List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem(
      value: '1',
      child: Text('Mécanicien'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Electricien'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Plombier'),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Maquilleuse'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('Coiffeur'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('Fanico'),
    ),
  ];

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text('Next'),
          ),
          const SizedBox(width: 10),
          OutlinedButton(
            onPressed: details.onStepCancel,
            child: const Text('Back'),
          ),
        ],
      ),
    );
  }

  Widget buildStep1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TextField(
          controller: nom_prestataire,
          decoration: InputDecoration(
            labelText: 'Nom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: prenom_prestataire,
          decoration: InputDecoration(
            labelText: 'Prenom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: username,
          decoration: InputDecoration(
            labelText: 'Nom d\'utilisateur',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: numero_cni,
          decoration: InputDecoration(
            labelText: 'Numéro CNI',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: biographie,
          decoration: InputDecoration(
            labelText: 'Biographie',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Mot de passe',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.visibility),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: phone_number,
          decoration: InputDecoration(
            labelText: 'Numero de telephone',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: services,
          onChanged: (String? newValue) {
            setState(() {
              services = newValue!;
            });
          },
          items: dropdownItems,
        ),
        const SizedBox(height: 10),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Date de naissance',
            border: OutlineInputBorder(),
          ),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: selectedDate,
              firstDate: DateTime(1900),
              lastDate: DateTime(2100),
            );
            if (pickedDate != null && pickedDate != selectedDate) {
              setState(() {
                selectedDate = pickedDate;
              });
            }
          },
        ),
      ],
    );
  }

  Widget buildStep2() {
    // Create controllers for text fields

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: ville,
          onChanged: (String? newValue) {
            setState(() {
              ville = newValue!;
            });
          },
          items: <String>[
            'ABIDJAN',
            'YAMOUSSOUKRO',
            'BOUAKE',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        DropdownButton<String>(
          value: commune,
          onChanged: (String? newValue) {
            setState(() {
              commune = newValue!;
            });
          },
          items: <String>[
            'COCODY',
            'MARCORY',
            'KOUMASSI',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: quartier, // Set obscureText to true for password field
          decoration: InputDecoration(
            labelText: 'Quartier',
            border: OutlineInputBorder(), // Icon to toggle password visibility
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: cite, // Set obscureText to true for password field
          decoration: InputDecoration(
            labelText: 'Cite',
            border: OutlineInputBorder(), // Icon to toggle password visibility
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller:
              numero_residence, // Set obscureText to true for password field
          decoration: InputDecoration(
            labelText: 'Numéro residence',
            border: OutlineInputBorder(), // Icon to toggle password visibility
          ),
        ),
      ],
    );
  }

  Widget buildStep3() {
    // Create controllers for text fields

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: selectPhotoPrestataire,
          child: Text('Prenez une photo de vous'),
        ),
        SizedBox(height: 10),
        if (photo_prestataire != null) Image.file(File(photo_prestataire!)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: selectPhotoPieceRecto,
          child: Text('Prenez une photo recto de votre pièce d\'identité'),
        ),
        SizedBox(height: 10),
        if (photo_piece_recto != null) Image.file(File(photo_piece_recto!)),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: selectPhotoPieceVerso,
          child: Text('Prenez une photo verso de votre pièce d\'identité'),
        ),
        SizedBox(height: 10),
        if (photo_piece_verso != null) Image.file(File(photo_piece_verso!)),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text('djossi',
                style: GoogleFonts.poppins(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff426CEA))),
            const SizedBox(
              height: 9,
            ),
            Stepper(
              elevation: 0, //Horizontal Impact
              // margin: const EdgeInsets.all(20), //vertical impact
              controlsBuilder: controlBuilders,
              type: StepperType.vertical,
              physics: const ScrollPhysics(),
              onStepTapped: onStepTapped,
              onStepContinue: continueStep,
              onStepCancel: cancelStep,
              currentStep: currentStep, //0, 1, 2
              steps: [
                Step(
                    title: Text('Information personnel'),
                    content: Column(
                      children: [
                        buildStep1(),
                      ],
                    ),
                    isActive: currentStep >= 0,
                    state: currentStep >= 0
                        ? StepState.complete
                        : StepState.disabled),
                Step(
                  title: const Text('Adresses'),
                  content: Column(
                    children: [
                      buildStep2(),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 1
                      ? StepState.complete
                      : StepState.disabled,
                ),
                Step(
                  title: const Text('Pièces d\'identités'),
                  content: Column(
                    children: [
                      buildStep3(),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
