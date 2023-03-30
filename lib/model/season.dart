class Season {
  Season({required this.name, required this.id});
  final String name;
  final int id;

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(name: json['name'], id: json['id']);
  }
}
