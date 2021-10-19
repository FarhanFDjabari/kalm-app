class User {
  User({
    this.id,
    this.name,
    this.email,
    this.username,
    this.jenisKelamin,
  });

  int? id;
  String? name;
  String? email;
  String? username;
  String? jenisKelamin;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        username: json["username"],
        jenisKelamin: json["jenis_kelamin"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "username": username,
        "jenis_kelamin": jenisKelamin,
      };
}
