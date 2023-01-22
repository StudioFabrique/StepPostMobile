import 'package:intl/intl.dart';

class InfosCourrier {
  int id;
  int bordereau;
  int type;
  String nom;
  String? prenom;
  String? civilite;
  String adresse;
  String? complement;
  String codePostal;
  String ville;
  String? telephone;
  int etat;
  DateTime date;

  InfosCourrier(
      {required this.id,
      required this.bordereau,
      required this.type,
      required this.nom,
      this.prenom,
      this.civilite,
      required this.adresse,
      this.complement,
      required this.codePostal,
      required this.ville,
      this.telephone,
      required this.etat,
      required this.date});

  factory InfosCourrier.fromJson(Map<String, dynamic> map) {
    return InfosCourrier(
      id: map['id'] as int,
      bordereau: map['bordereau'] as int,
      type: map['type'] as int,
      nom: map['nom'] as String,
      prenom: map['prenom'] ?? null,
      civilite: map['civilite'] ?? null,
      adresse: map['adresse'] as String,
      complement:
          map['complement'] != null ? map['complement'] as String : null,
      codePostal: map['codePostal'] as String,
      ville: map['ville'] as String,
      telephone: map['telephone'] ?? null,
      etat: map['etat'] as int,
      date: DateTime.parse((map['date'])),
    );
  }
}
