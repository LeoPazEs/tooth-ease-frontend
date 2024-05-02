import 'package:tooth_ease_frontend/app/modules/kids/data/entities/kid_entities.dart';

class KidAdapter {
  KidAdapter._();

  static CompleteKidEntity fromJson(dynamic json) => CompleteKidEntity(
        id: json["id"],
        name: json["name"],
        birthDate: DateTime.parse(json["birth_date"]),
        age: json["age"],
      );

  static Map<String, dynamic> toJson(KidEntity kidEntity) => {
        "name": kidEntity.name,
        "birth_date": kidEntity.birthDate.toIso8601String(),
      };
}
