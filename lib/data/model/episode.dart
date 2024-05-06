class Episode {
  Episode({
    required this.id,
    required this.thumbnail,
    required this.episodeNum,
    required this.url,
    required this.skipStart,
    required this.skipEnd,
    required this.localName,
    required this.localDescription,
    required this.seasonLocalDescription,
    required this.tags,
    required this.seasonNum,
    required this.seasonImage,
    required this.episodeTime,
    this.showId,
  });

  final int? id;
  final String? thumbnail;
  final String? episodeNum;
  final String? url;
  final String? skipStart;
  final String? skipEnd;
  final String? localName;
  final String? localDescription;
  final String? seasonLocalDescription;
  final List<String> tags;
  final String? seasonNum;
  final String? seasonImage;
  final dynamic episodeTime;
  int? showId;

  Episode copyWith({
    int? id,
    String? thumbnail,
    String? episodeNum,
    String? url,
    String? skipStart,
    String? skipEnd,
    String? localName,
    String? localDescription,
    String? seasonLocalDescription,
    List<String>? tags,
    String? seasonNum,
    String? seasonImage,
    dynamic? episodeTime,
    int? showId,
  }) {
    return Episode(
      id: id ?? this.id,
      thumbnail: thumbnail ?? this.thumbnail,
      episodeNum: episodeNum ?? this.episodeNum,
      url: url ?? this.url,
      skipStart: skipStart ?? this.skipStart,
      skipEnd: skipEnd ?? this.skipEnd,
      localName: localName ?? this.localName,
      localDescription: localDescription ?? this.localDescription,
      seasonLocalDescription:
          seasonLocalDescription ?? this.seasonLocalDescription,
      tags: tags ?? this.tags,
      seasonNum: seasonNum ?? this.seasonNum,
      seasonImage: seasonImage ?? this.seasonImage,
      episodeTime: episodeTime ?? this.episodeTime,
      showId: showId ?? this.showId,
    );
  }

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json["id"],
      thumbnail: json["thumbnail"],
      episodeNum: json["episode_num"],
      url: json["url"],
      skipStart: json["skip_start"],
      skipEnd: json["skip_end"],
      localName: json["local_name"],
      localDescription: json["local_description"],
      seasonLocalDescription: json["season_local_description"],
      tags: json["tags"] == null
          ? []
          : List<String>.from(json["tags"]!.map((x) => x)),
      seasonNum: json["season_num"],
      seasonImage: json["season_image"],
      episodeTime: json["episode_time"],
      showId: json["show_id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "episode_num": episodeNum,
        "url": url,
        "skip_start": skipStart,
        "skip_end": skipEnd,
        "local_name": localName,
        "local_description": localDescription,
        "season_local_description": seasonLocalDescription,
        "tags": tags.map((x) => x).toList(),
        "season_num": seasonNum,
        "season_image": seasonImage,
        "episode_time": episodeTime,
        "show_id": showId,
      };

  @override
  String toString() {
    return "$id, $thumbnail, $episodeNum, $url, $skipStart, $skipEnd, $localName, $localDescription, $seasonLocalDescription, $tags, $seasonNum, $seasonImage, $episodeTime, ";
  }
}
