import 'dart:convert';

import 'package:djossi_mobile_app/Authentication.dart';
import 'package:djossi_mobile_app/constants.dart';
import 'package:djossi_mobile_app/models.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;

  List<DemandeService> allServie = [];

  Future<void> acceptDemande(String reservationId) async {
    try {
      final response =
          await get(Uri.parse("${AppUrl.accepterReservation}$reservationId/"));
      debugPrint(
          "La requete a ete lance, voici le contenu : ${AppUrl.accepterReservation}/$reservationId");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final data = responseData['data'];

        debugPrint(data.toString());
        debugPrint(
            "La requete a reussis, voici le contenu de la reponse : $responseData");
      } else {
        var responseData = json.decode(response.body);
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
    }
  }

  Future<void> cancelDemande(String reservationId) async {
    try {
      final response =
          await get(Uri.parse("${AppUrl.annulerReservation}$reservationId/"));
      debugPrint(
          "La requete a ete lance, voici le contenu : ${AppUrl.annulerReservation}/$reservationId");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final data = responseData['data'];

        debugPrint(data.toString());
        debugPrint(
            "La requete a reussis, voici le contenu de la reponse : $responseData");
      } else {
        var responseData = json.decode(response.body);
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
    }
  }

  Future<void> finishDemande(String reservationId) async {
    try {
      final response =
          await get(Uri.parse("${AppUrl.finirReservation}$reservationId/"));
      debugPrint(
          "La requete a ete lance, voici le contenu : ${AppUrl.finirReservation}/$reservationId");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        final data = responseData['data'];

        debugPrint(data.toString());
        debugPrint(
            "La requete a reussis, voici le contenu de la reponse : $responseData");
      } else {
        var responseData = json.decode(response.body);
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
    }
  }

  Future<void> getAllDemandesServices() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response =
          await get(Uri.parse("${AppUrl.getReservation}${prestataire.id}/"));
      debugPrint(
          "La requete a ete lance, voici le contenu : ${AppUrl.getReservation}${prestataire.id}");
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        debugPrint(responseData.toString());
        allServie = [];

        final data = responseData['data'];

        for (dynamic serviceData in data) {
          final service = DemandeService.fromJson(serviceData);

          allServie.add(service);
        }
        debugPrint(data.toString());
        debugPrint(
            "La requete a reussis, voici le contenu de la reponse : $responseData");
      } else {
        var responseData = json.decode(response.body);
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

  @override
  void initState() {
    getAllDemandesServices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "${AppUrl.onlineSimpleUrl}/${prestataire.profileUrl}"),
            ),
            const SizedBox(width: 10),
            Text("Bienvenue, ${prestataire.prenom}",
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.black)),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 30,
              color: Colors.black,
            ),
            onPressed: () {
              // Action when notification icon is pressed
            },
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async {
                await getAllDemandesServices();
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: allServie.reversed
                      .map(
                        (demandeService) => DemadeServiceWidget(
                          imageUrl: demandeService.photoUrl!,
                          nomClient: demandeService.nomClient!,
                          status: demandeService.status!,
                          prenomClient: demandeService.preNomClient!,
                          id: demandeService.id!,
                          acceptService: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            await acceptDemande(demandeService.id!);
                            Navigator.pop(context);
                            await getAllDemandesServices();
                          },
                          cancelService: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            await cancelDemande(demandeService.id!);
                            Navigator.pop(context);
                            await getAllDemandesServices();
                          },
                          finishService: () async {
                            showDialog(
                              context: context,
                              builder: (ctx) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                            await finishDemande(demandeService.id!);
                            Navigator.pop(context);
                            await getAllDemandesServices();
                          },
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
    );
  }
}

class DemadeServiceWidget extends StatelessWidget {
  const DemadeServiceWidget({
    Key? key,
    required this.id,
    required this.nomClient,
    required this.status,
    required this.prenomClient,
    required this.imageUrl,
    this.acceptService,
    this.cancelService,
    this.finishService,
  }) : super(key: key);

  final String id;
  final String imageUrl;
  final String nomClient;
  final String prenomClient;
  final StatusDemande status;
  final VoidCallback? acceptService;
  final VoidCallback? cancelService;
  final VoidCallback? finishService;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage:
                      NetworkImage("${AppUrl.onlineSimpleUrl}/$imageUrl"),
                ),
              ),
            ),
            if (status == StatusDemande.demamde)
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      "$prenomClient $nomClient",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: acceptService,
                          child: const Text("Accepter"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: finishService,
                          child: const Text("Refuser"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            else if (status == StatusDemande.enCours)
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Text(
                      "$prenomClient $nomClient",
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    ElevatedButton(
                      onPressed: finishService,
                      child: const Text("Terminer"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          textStyle: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              )
            else if (status == StatusDemande.termine)
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    "$prenomClient $nomClient",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
              )
            else if (status == StatusDemande.annule)
              Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    "$prenomClient $nomClient",
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
              ),
            if (status == StatusDemande.demamde)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: FittedBox(
                    child: Text('Demandé',
                        style: GoogleFonts.poppins(color: Colors.green)),
                  ),
                ),
              ),
            if (status == StatusDemande.enCours)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: FittedBox(
                    child: Text(
                      'En cours',
                      style: GoogleFonts.poppins(color: Colors.orange),
                    ),
                  ),
                ),
              )
            else if (status == StatusDemande.termine)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: FittedBox(
                    child: Text(
                      'Terminé',
                      style: GoogleFonts.poppins(color: Colors.green),
                    ),
                  ),
                ),
              )
            else if (status == StatusDemande.annule)
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: FittedBox(
                    child: Text(
                      'Annulé',
                      style: GoogleFonts.poppins(color: Colors.red),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
