class User {
  late String id;
  late String name;
  late String email;
  late String createdAt;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        createdAt: json['timestamp']);
  }
}
