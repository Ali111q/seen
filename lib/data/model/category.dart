import 'show.dart';

class Category {
  final int id;
  final String local_name;
  List<Show?>? shows = [];

  Category({required this.id, required this.local_name, this.shows});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'],
        local_name: json['local_name'],
        shows: List.from(json['shows'].map((x) => Show.fromJson(x))));
  }

  Map toJson() {
    return {
      'id': id,
      'local_name': local_name,
      'shows': shows!.map((e) => e!.toJson()).toList(),
    };
  }

  addShow(Show show) {
    shows!.add(show);
  }

  clearShow() {
    shows!.clear();
  }

  void setShows(List<Show> shows) {
    this.shows = shows;
  }
}
