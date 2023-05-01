import 'package:video_player/video_player.dart';

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
late  VideoPlayerController controller;
  ReelVideo(
      {required this.id,
      required this.title,
      required this.url,
      required this.views_count,
      required this.comments_count,
      required this.likes_count}){
        print('ksdl fjiosd hjfiolsd fhsd');
         controller = VideoPlayerController.network(url);
      }

  factory ReelVideo.fromJson(Map<String, dynamic> json) {
    return ReelVideo(
        id: json['id'],
        title: json['title'],
        url: json['url'],
        views_count: json['views_count'],
        comments_count: json['comments_count'],
        likes_count: json['likes_count']);
  }
}
