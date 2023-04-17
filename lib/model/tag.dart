import 'package:seen/model/show.dart';

class Tag {
  final int id;
  final String local_name;
  List<Show?>? shows = [];

  Tag({required this.id, required this.local_name, this.shows});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(id: json['id'], local_name: json['local_name'], shows: []);
  }

  addShow(Show show) {
    shows!.add(show);
  }

  clearShow() {
    shows!.clear();
  }
}
