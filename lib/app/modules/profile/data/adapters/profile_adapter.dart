import 'package:intl/intl.dart';
import 'package:tooth_ease_frontend/app/modules/profile/data/entities/profile_entities.dart';

class ProfileAdapter {
  ProfileAdapter._();

  static ProfileEntity fromJson(dynamic json, UserEntity user) => ProfileEntity(
        user: user,
        birthDate: json["birth_date"] != null
            ? DateTime.parse(json["birth_date"])
            : null,
        age: json["age"],
      );

  static Map<String, dynamic> toJson(PatchProfileEntity profileEntity) => {
        "birth_date": DateFormat('yyyy-MM-dd').format(profileEntity.birthDate),
      };
}

class UserAdapter {
  UserAdapter._();

  static UserEntity fromJson(dynamic json) => UserEntity(
        id: json["id"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        fullName: json["full_name"],
      );
}
