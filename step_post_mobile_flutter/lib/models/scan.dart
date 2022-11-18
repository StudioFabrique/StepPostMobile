import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Scan {
  int id;
  DateTime date;
  int statutId;
  int bordereau;

  Scan({
    required this.id,
    required this.date,
    required this.statutId,
    required this.bordereau,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'date': date.millisecondsSinceEpoch,
      'statutId': statutId,
      'bordereau': bordereau,
    };
  }

  factory Scan.fromMap(Map<String, dynamic> map) {
    return Scan(
      id: map['id'] as int,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      statutId: map['statutId'] as int,
      bordereau: map['bordereau'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Scan.fromJson(String source) =>
      Scan.fromMap(json.decode(source) as Map<String, dynamic>);
}
