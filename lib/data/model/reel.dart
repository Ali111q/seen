import 'package:video_player/video_player.dart';

import 'ad.dart';

class Reel {
  final int id;
  final String image;
  final local_name;
  final local_title;

  Reel(
      {required this.id,
      required this.image,
      this.local_name,
      this.local_title});

  factory Reel.fromJson(Map<String, dynamic> json) {
    return Reel(
      id: json['id'],
      image: json['image'],
      local_name: json['local_name'],
      local_title: json['local_title'],
    );
  }
}

class ReelVideo {
  final int id;
  final String title;
  final String url;
  final int views_count;
  final int comments_count;
  final int likes_count;
  final Ad? ad;
  final String thumbnail;
  final bool isLiked;
  ReelVideo(
      {required this.id,
      required this.title,
      required this.url,
      required this.views_count,
      required this.comments_count,
      required this.likes_count,
      required this.thumbnail,
      required this.isLiked,
      this.ad});

  factory ReelVideo.fromJson(Map<String, dynamic> json) {
    return ReelVideo(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        views_count: json['views_count'],
        comments_count: json['comments_count'],
        likes_count: json['likes_count'],
        thumbnail: json['thumbnail'],
        ad: json['ads'] != null ? Ad.fromJson(json['ads']) : null,
        isLiked: json['isLiked']);
  }

  ReelVideo copyWith({
    int? id,
    String? title,
    String? url,
    int? views_count,
    int? comments_count,
    int? likes_count,
    String? thumbnail,
    bool? isLiked,
    Ad? ad,
  }) {
    return ReelVideo(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
      views_count: views_count ?? this.views_count,
      comments_count: comments_count ?? this.comments_count,
      likes_count: likes_count ?? this.likes_count,
      thumbnail: thumbnail ?? this.thumbnail,
      isLiked: isLiked ?? this.isLiked,
      ad: ad ?? this.ad,
    );
  }
}

class Comment {
  int id;
  String comment;
  String userName;
  String image;
  Comment(
      {required this.comment,
      required this.id,
      required this.image,
      required this.userName});
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        comment: json['comment'],
        id: json['id'],
        image: json['users']['image'],
        userName: json['users']['name']);
  }
}
