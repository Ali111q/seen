class User {
  User(
      {required this.name,
      required this.email,
      this.token,
      required this.image});
  final String name;
  final String email;
  final String? token;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        token: json['token'],
        email: json['email'],
        image: json['image']);
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'image': image,
    };
  }
}
