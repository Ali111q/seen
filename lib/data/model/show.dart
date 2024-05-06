import 'package:seen/data/model/episode.dart';
import 'package:seen/data/model/season.dart';

class Show {
  Show(
      {required this.name,
      this.seasons,
      required this.description,
      required this.image,
      required this.id,
      required this.creator,
      this.firstEpisode,
      this.trailer,
      this.year});
  final String name;
  final String? image;
  final int id;
  final String? creator;
  final String? year;
  final String? trailer;
  final Episode? firstEpisode;
  final String description;
  final List<Season>? seasons;
  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      image: json['image'],
      seasons: json['season'] == null
          ? null
          : List<Season>.from(json['season'].map((x) => Season.fromJson(x))),
      name: json['local_name'],
      description: json['local_description'],
      id: json['id'],
      creator: json['creator'],
      trailer: json['trailer'],
      year: json['date'],
      firstEpisode: json['first_episode'] != null
          ? Episode.fromJson(json['first_episode'])
          : null,
    );
  }
  Map toJson() {
    return {
      'local_name': name,
      'image': image,
      'id': id,
      'creator': creator,
      'trailer': trailer,
      'date': year,
    };
  }
}
