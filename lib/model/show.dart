class Show {
  Show(
      {required this.name,
      required this.image,
      required this.id,
      required this.creator,
      this.trailer, this.year});
  final String name;
  final String? image;
  final int id;
  final String creator;
  final String? year;
  final String? trailer;
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
        name: json['local_name'],
        image: json['image'],
        id: json['id'],
        creator: json['creator'],
        trailer: json['trailer'], year: json['date']);
  }
}
