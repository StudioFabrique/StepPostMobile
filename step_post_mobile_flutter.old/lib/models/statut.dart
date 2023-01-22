class Statut {
  int id;
  int statutCode;
  String etat;

  Statut({
    required this.id,
    required this.statutCode,
    required this.etat,
  });

  factory Statut.fromJson(Map<String, dynamic> map) {
    return Statut(
      id: map['id'] as int,
      statutCode: map['statutCode'] as int,
      etat: map['etat'] as String,
    );
  }
}
