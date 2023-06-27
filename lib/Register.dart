import 'dart:convert';
import 'dart:io';
import 'package:djossi_mobile_app/Authentication.dart';
import 'package:djossi_mobile_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:djossi_mobile_app/onboarding.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late ScaffoldMessengerState scaffoldMessengerState;
  int currentStep = 0;
  String services = '1';
  DateTime selectedDate = DateTime.now();
  TextEditingController nom_prestataire = TextEditingController();
  TextEditingController date = TextEditingController();
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
  File? photo_prestataire;
  File? photo_piece_recto;
  File? photo_piece_verso;
  String? errorMessage;
  String? successMessage;
  bool isFormEnable = true;
  bool isLoading = false;

  void continueStep() async {
    if (currentStep < 2) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    } else if (currentStep >= 2) {
      setState(() {
        isLoading = true;
      });
      var formattedDate = DateFormat('y-M-d').format(selectedDate);

      // Envoyer la requête POST
      var request = MultipartRequest(
        'POST',
        Uri.parse(AppUrl.inscriptionPrestataire),
      );

      final photoPrestataireFileBytes = await photo_prestataire!.readAsBytes();
      var photoPrestataireFile = MultipartFile.fromBytes(
        'photo_prestataire',
        photoPrestataireFileBytes,
        filename: path.basename(photo_prestataire!.path),
        contentType: MediaType('image', 'jpg'),
      );

      final photorectoFileBytes = await photo_piece_recto!.readAsBytes();
      var photorectoFile = MultipartFile.fromBytes(
        'photo_piece_recto',
        photoPrestataireFileBytes,
        filename: path.basename(photo_piece_recto!.path),
        contentType: MediaType('image', 'jpg'),
      );

      final photoversoFileBytes = await photo_piece_verso!.readAsBytes();
      var photoversoFile = MultipartFile.fromBytes(
        'photo_piece_verso',
        photoPrestataireFileBytes,
        filename: path.basename(photo_piece_verso!.path),
        contentType: MediaType('image', 'jpg'),
      );

      request.fields['nom_prestataire'] = nom_prestataire.text;
      request.fields['prenom_prestataire'] = prenom_prestataire.text;
      request.fields['services'] = services;
      request.fields['username'] = username.text;
      request.fields['password'] = password.text;
      request.fields['phone_number'] = phone_number.text;
      request.fields['numero_cni'] = numero_cni.text;
      request.fields['biographie'] = biographie.text;
      request.fields['date_naissance'] = formattedDate;
      request.fields['ville'] = ville;
      request.fields['commune'] = commune;
      request.fields['quartier'] = quartier.text;
      request.fields['numero_residence'] = numero_residence.text;
      request.files.add(photoPrestataireFile);
      request.files.add(photorectoFile);
      request.files.add(photoversoFile);

      var response = await request.send();
      var res = await response.stream.bytesToString();
      // Vérifier le code de réponse
      if (response.statusCode == 200) {
        debugPrint(res);
        scaffoldMessengerState.showSnackBar(
          const SnackBar(
            content: Text('Inscription réussie'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (ctx) => Authentication()));
        // print(responseData);
        // Traitez la réponse ici
      } else {
        debugPrint(response.statusCode.toString());
        debugPrint(request.fields.toString());
        debugPrint(response.toString());
        scaffoldMessengerState.showSnackBar(
          const SnackBar(
            content: Text(
                'Erreur lors de l\'inscription, veuillez bien rentrer tous les champs'),
            backgroundColor: Colors.red,
          ),
        );
        // print(responseData);
        // print('Request failed with status: ${response.statusCode}');
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  void cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  void onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Future<void> selectPhotoPrestataire() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_prestataire = File(pickedFile.path);
      });
    }
  }

  Future<void> selectPhotoPieceRecto() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_piece_recto = File(pickedFile.path);
      });
    }
  }

  Future<void> selectPhotoPieceVerso() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        photo_piece_verso = File(pickedFile.path);
      });
    }
  }

  List<DropdownMenuItem<String>> dropdownItems = [
    const DropdownMenuItem(
      value: '1',
      child: Text('Mécanicien'),
    ),
    const DropdownMenuItem(
      value: '2',
      child: Text('Electricien'),
    ),
    const DropdownMenuItem(
      value: '3',
      child: Text('Plombier'),
    ),
    const DropdownMenuItem(
      value: '4',
      child: Text('Maquilleuse'),
    ),
    const DropdownMenuItem(
      value: '5',
      child: Text('Coiffeur'),
    ),
    const DropdownMenuItem(
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
          decoration: const InputDecoration(
            labelText: 'Nom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: prenom_prestataire,
          decoration: const InputDecoration(
            labelText: 'Prenom',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: username,
          decoration: const InputDecoration(
            labelText: 'Nom d\'utilisateur',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: numero_cni,
          decoration: const InputDecoration(
            labelText: 'Numéro CNI',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: biographie,
          decoration: const InputDecoration(
            labelText: 'Biographie',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: password,
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Mot de passe',
            border: OutlineInputBorder(),
            suffixIcon: Icon(Icons.visibility),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: phone_number,
          decoration: const InputDecoration(
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
          enabled: isFormEnable,
          controller: date,
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
                date.text = pickedDate.toString();
                isFormEnable = false;
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
          decoration: const InputDecoration(
            labelText: 'Quartier',
            border: OutlineInputBorder(), // Icon to toggle password visibility
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: cite, // Set obscureText to true for password field
          decoration: const InputDecoration(
            labelText: 'Cite',
            border: OutlineInputBorder(), // Icon to toggle password visibility
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller:
              numero_residence, // Set obscureText to true for password field
          decoration: const InputDecoration(
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
          child: const Text('Prenez une photo de vous'),
        ),
        const SizedBox(height: 10),
        if (photo_prestataire != null) Image.file(photo_prestataire!),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: selectPhotoPieceRecto,
          child:
              const Text('Prenez une photo recto de votre pièce d\'identité'),
        ),
        const SizedBox(height: 10),
        if (photo_piece_recto != null) Image.file(photo_piece_recto!),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: selectPhotoPieceVerso,
          child:
              const Text('Prenez une photo verso de votre pièce d\'identité'),
        ),
        const SizedBox(height: 10),
        if (photo_piece_verso != null) Image.file(photo_piece_verso!),
        const SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    scaffoldMessengerState = ScaffoldMessenger.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )),
          SingleChildScrollView(
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
                        title: const Text('Information personnel'),
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
        ],
      ),
    );
  }
}
