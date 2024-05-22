class User {
  User(
      {required this.name,
      required this.email,
      this.token,
      required this.image});
  String name;
  String email;
  String? token;
  String image;

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

  User copyWith({
    String? name,
    String? email,
    String? token,
    String? image,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      token: token ?? this.token,
      image: image ?? this.image,
    );
  }
}
