import 'package:seen/model/episode.dart';

class Season {
  Season(
      {required this.season_number,
      required this.image,
      required this.date,
      required this.trailer,
      required this.local_name,
      required this.local_description,
      required this.id});
  final int id;
  final String season_number;
  final String image;
  final String date;
  final String trailer;
  final String local_name;
  final String local_description;
  List<Episode> episods = [];

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
        season_number: json['season_number'],
        image: json['image'],
        date: json['date'],
        trailer: json['trailer'],
        local_name: json['local_name'],
        local_description: json['local_description'],
        id: json['id']);
  }

  void addEpisode(Episode episode) {
    episods.add(episode);
  }

  void clearEpisodes() {
    episods.clear();
  }
}
