class Episode {
  Episode({
    required this.id,
    required this.thumbnail,
    required this.episode_num,
    required this.url,
    this.local_name,
    this.local_description,
    required this.tags,
    required this.season_num,
  });
  final int id;
  final String thumbnail;
  final String episode_num;
  final String url;
  final String? local_name;
  final String? local_description;
  final List tags;
  final String season_num;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      thumbnail: json['thumbnail'],
      episode_num: json['episode_num'],
      url: json['url'],
      tags: json['tags'],
      season_num: json['season_num'],
      local_name: json['local_name'],
      local_description: json['local_description'],
    );
  }
}
