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



class DemandeService{
  final String photoUrl;

  DemandeService(this.photoUrl);
}