import 'package:flutter/material.dart';

class Prestataire {
  final String id;
  final String profileUrl;
  final String nom;
  final String prenom;

  Prestataire(
      {required this.id,
      required this.profileUrl,
      required this.nom,
      required this.prenom});
}

enum StatusDemande { enCours, termine, demamde, annule }

class DemandeService {
  String? id;
  String? photoUrl;
  String? nomClient;
  String? preNomClient;
  DateTime? dateReservatioon;
  StatusDemande? status;

  DemandeService(
      {required this.id,
      required this.dateReservatioon,
      required this.photoUrl,
      required this.nomClient,
      required this.status});

  StatusDemande? getStatus(String statusString) {
    if (statusString == 'DemandÃ©') {
      return StatusDemande.demamde;
    } else if (statusString == 'AnnulÃ©') {
      return StatusDemande.annule;
    } else if (statusString == 'TerminÃ©') {
      return StatusDemande.termine;
    } else if (statusString == 'En cours') {
      return StatusDemande.enCours;
    } else {
      return null;
    }
  }

  DemandeService.fromJson(Map<String, dynamic> json) {
    json['id'].isEmpty ? id = null : id = json['id'];

    json['date_reservation'].isEmpty
        ? dateReservatioon = null
        : dateReservatioon = DateTime.parse(json['date_reservation']);

    debugPrint("Converting reservation");
    json['status_reservation'].isEmpty
        ? status = null
        : status = getStatus(json['status_reservation']);

    json['client']['nom_client'].isEmpty
        ? nomClient = ''
        : nomClient = json['client']['nom_client'];

    json['client']['prenom_client'].isEmpty
        ? preNomClient = ''
        : preNomClient = json['client']['prenom_client'];

    json['client']['photo_client'].isEmpty
        ? photoUrl = ''
        : photoUrl = json['client']['photo_client'];
  }
}
