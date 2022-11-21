import 'package:step_post_mobile_flutter/models/courrier.dart';

class SearchScan {
  DateTime date;
  int statut;
  Courrier courrier;

  SearchScan({
    required this.date,
    required this.statut,
    required this.courrier
});

  factory SearchScan.fromJson(Map<String, dynamic> map) {
    return SearchScan(
        date: DateTime.parse(map['date']),
        statut: map['s']['statutCode'],
        courrier: Courrier.fromJson(map['courrier'])
    );
  }
}