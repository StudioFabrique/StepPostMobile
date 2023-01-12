class Courrier {
  int id;
  int bordereau;
  int type;
  String? telephone;

  Courrier(
      {required this.id,
      required this.bordereau,
      required this.type,
      this.telephone});

  factory Courrier.fromJson(Map<String, dynamic> map) {
    return Courrier(
        id: map['id'] as int,
        bordereau: map['bordereau'] as int,
        type: map['type'] as int,
        telephone: map['telephone'] ?? null);
  }
}
