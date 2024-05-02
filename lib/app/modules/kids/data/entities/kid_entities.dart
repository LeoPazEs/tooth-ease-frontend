abstract class KidEntity {
  final String name;
  final DateTime birthDate;

  KidEntity({
    required this.name,
    required this.birthDate,
  });
}

class CompleteKidEntity extends KidEntity {
  final int id;
  final int age;

  CompleteKidEntity({
    required this.id,
    required this.age,
    required super.name,
    required super.birthDate,
  });
}

class CreateKidEntity extends KidEntity {
  CreateKidEntity({required super.name, required super.birthDate});
}
