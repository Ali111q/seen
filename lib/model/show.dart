class Show {
  Show({required this.name, required this.image, required this.id});
  final String name;
  final String image;
  final int id;

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(name: json['name'], image: json['image'], id: json['']);
  }
}
