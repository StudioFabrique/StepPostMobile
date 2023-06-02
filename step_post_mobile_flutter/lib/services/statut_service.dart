import 'package:step_post_mobile_flutter/models/statut.dart';

class StatutService {
  List<Statut> etats = [
    Statut(id: 1, etat: "en attente", statutCode: 1),
    Statut(id: 2, etat: "pris en charge", statutCode: 2),
    Statut(id: 3, etat: "avisé", statutCode: 3),
    Statut(id: 4, etat: "mis en instance", statutCode: 4),
    Statut(id: 5, etat: "distribué", statutCode: 5),
    Statut(id: 6, etat: "NPAI", statutCode: 6),
    Statut(id: 7, etat: "non réclamé", statutCode: 7),
    Statut(id: 8, etat: "erreur de libellé", statutCode: 8),
    Statut(id: 9, etat: "distribué", statutCode: 9),
  ];

  List<Statut> getStatuts() => etats;
}
