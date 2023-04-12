class Episode {
  Episode({
    required this.id,
    required this.thumbnail,
    required this.episode_num,
    this.local_name,
    required this.url_480,
    required this.url_720,
    required this.url_1080,
    this.local_description,
    required this.tags,
    required this.season_num,
  });
  final int id;
  final String thumbnail;
  final String episode_num;

  final String url_480;
  final String url_720;
  final String url_1080;
  final String? local_name;
  final String? local_description;
  final List tags;
  final String season_num;

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'],
      thumbnail: json['thumbnail'],
      episode_num: json['episode_num'],
      tags: json['tags'],
      season_num: json['season_num'],
      local_name: json['local_name'],
      local_description: json['local_description'],
      url_1080: json['url_1080'],
      url_720: json['url_720'],
      url_480: json['url_480'],
    );
  }
}
