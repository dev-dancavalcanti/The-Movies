class UserModel {
  final String name;
  final String email;
  final String dateBirthday;
  final String picture;

  UserModel({
    required this.name,
    required this.email,
    required this.dateBirthday,
    required this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        name: json['name'],
        email: json['email'],
        picture: json['picture'],
        dateBirthday: json['dateBirthday']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'picture': picture,
      'dateBirthday': dateBirthday,
    };
  }

  then(Future<Null> Function(dynamic val) param0) {}
}
