class UserEntity {
  final int id;
  final String username;
  final String firstName;
  final String lastName;
  final String fullName;

  UserEntity(
      {required this.id,
      required this.username,
      required this.firstName,
      required this.lastName,
      required this.fullName});
}

class ProfileEntity {
  final UserEntity user;
  final DateTime? birthDate;
  final int? age;

  ProfileEntity({
    required this.user,
    required this.birthDate,
    required this.age,
  });
}

class PatchProfileEntity {
  final DateTime birthDate;

  PatchProfileEntity({
    required this.birthDate,
  });
}
