import 'package:step_post_mobile_flutter/models/statut.dart';

import 'courrier.dart';

class Scan {
  DateTime date;
  int etat;
  Courrier courrier;

  Scan({
    required this.date,
    required this.etat,
    required this.courrier,
  });

  factory Scan.fromJson(Map<String, dynamic> map) {
    return Scan(
      date: DateTime.parse((map['date'])),
      etat:  map['s']['statutCode'],
      courrier : Courrier.fromJson(map['courrier'])
    );
  }
}
