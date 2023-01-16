class Courrier {
  int id;
  int bordereau;
  int type;

  Courrier({required this.id, required this.bordereau, required this.type});

  factory Courrier.fromJson(Map<String, dynamic> map) {
    return Courrier(
        id: map['id'] as int,
        bordereau: map['bordereau'] as int,
        type: map['type'] as int);
  }
}
