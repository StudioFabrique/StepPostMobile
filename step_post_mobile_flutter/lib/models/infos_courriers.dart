// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class InfosCourrier {
  int id;
  int bordereau;
  int type;
  String nom;
  String prenom;
  String civilite;
  String adresse;
  String? complement;
  String codePostal;
  String ville;
  int etat;
  DateTime date;

  InfosCourrier(
      {required this.id,
      required this.bordereau,
      required this.type,
      required this.nom,
      required this.prenom,
      required this.civilite,
      required this.adresse,
      this.complement,
      required this.codePostal,
      required this.ville,
      required this.etat,
      required this.date});

  factory InfosCourrier.fromJson(Map<String, dynamic> map) {
    return InfosCourrier(
      id: map['id'] as int,
      bordereau: map['bordereau'] as int,
      type: map['type'] as int,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      civilite: map['civilite'] as String,
      adresse: map['adresse'] as String,
      complement:
          map['complement'] != null ? map['complement'] as String : null,
      codePostal: map['codePostal'] as String,
      ville: map['ville'] as String,
      etat: map['etat'] as int,
      date: DateTime.parse((map['date'])),
    );
  }
}