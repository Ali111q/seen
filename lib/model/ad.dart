import 'dart:async';

import 'package:video_player/video_player.dart';

class Ad {
  final int id;
  final String? lat;
  final String? lng;
  final String file;
  final String? thumbnail;
  final String file_type;
  final String? instagram;
  final String? website;
  final String local_title;
  final String local_description;
  final String local_sub_title;
  late VideoPlayerController controller;

  Ad(
      {this.thumbnail,
      required this.file_type,
      required this.id,
      this.lat,
      this.lng,
      required this.file,
      this.instagram,
      this.website,
      required this.local_title,
      required this.local_description,
      required this.local_sub_title}) {
    position = positionController.stream;
    isPlaying = isPlayingController.stream;
    isInitialized = isInitializedController.stream;
  }

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
        id: json['id'],
        file: json['file'],
        local_title: json['local_title'],
        local_description: json['local_description'],
        lat: json['lat'],
        lng: json['lng'],
        instagram: json['instagram'],
        website: json['website'],
        file_type: json['file_type'],
        thumbnail: json['thumbnail'],
        local_sub_title: json['local_sub_title']);
  }

  Future<void> intilize() async {
    if (file_type == 'video') {
      controller = VideoPlayerController.network(file);
      await controller.initialize();
      controller.addListener(() {
        positionController
            .add(controller.value.position.inMilliseconds.toDouble());
        isInitializedController.add(controller.value.isInitialized);
      });
      controller.play();
    }
  }

  Future<void> dispos() async {
    if (file_type == 'video') {
      await controller.dispose();
    }
  }

  void play() {
    if (file_type == 'video') {
      controller.play();
      isPlayingController.add(true);
    }
  }

  void pause() {
    if (file_type == 'video') {
      controller.pause();
      isPlayingController.add(false);
    }
  }

  void setLooping(bool looping) {
    if (file_type == 'video') {
      controller.setLooping(looping);
    }
  }

  StreamController<double> positionController = StreamController();
  Stream<double> position = Stream.empty();
  StreamController<bool> isPlayingController = StreamController();
  Stream<bool> isPlaying = Stream.empty();
  StreamController<bool> isInitializedController = StreamController();
  Stream<bool> isInitialized = Stream.empty();
}
