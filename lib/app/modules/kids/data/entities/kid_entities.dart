class KidEntity {
  final int id;
  final String name;
  final DateTime birthDate;
  final int age;

  KidEntity(
      {required this.id,
      required this.name,
      required this.birthDate,
      required this.age});

  factory KidEntity.fromJson(Map<String, dynamic> json) {
    return KidEntity(
        id: json["id"],
        name: json["name"],
        birthDate: DateTime.parse(json["birth_date"]),
        age: json["age"]);
  }
}
