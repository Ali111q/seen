import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';
import 'package:just_audio/just_audio.dart';

import '../data/model/radio.dart';

class RadioController extends GetxController {
  RxInt channelId = 0.obs;
  RxBool radioState = RxBool(false);
  RxBool isPlaying = false.obs;
  List<RadioChannel> radioList = [
    RadioChannel(
        bodcasterImage: 'assets/png/yassir.PNG',
        id: 1,
        name: ' بودكاست',
        enName: 'Podcast',
        subtitle: 'تعال نسولف بمواضيعنا',
        enSubtitle: "Let's Talk",
        bodcaster: 'ياسر سامي',
        image: 'assets/png/mic.jpg',
        url: 'https://stream.app-seen.com/live/radio1.m3u8'),
    RadioChannel(
        bodcasterImage: 'assets/png/talent1.JPG',
        id: 2,
        name: 'راديو تراث عراقي',
        enName: 'Iraqi Old Radio',
        subtitle: 'أغاني تراثية عراقية ترجع لزمن الطيبين',
        enSubtitle: 'Nostalgia for Old Iraqi Songs',
        bodcaster: 'راديو تراث عراقي',
        image: 'assets/png/music.png',
        url: 'https://stream.app-seen.com/live/radio2.m3u8'),
    RadioChannel(
        bodcasterImage: 'assets/png/old.png',
        id: 3,
        name: 'راديو راب',
        enName: 'Radio Rap',
        subtitle: 'منوع و أخبار فن الراب وسين العراقي',
        enSubtitle: 'All about the Iraqi Rap Seen.',
        bodcaster: 'راديو راب',
        image: 'assets/png/rap.JPG',
        url: 'https://stream.app-seen.com/live/radio3.m3u8'),
    RadioChannel(
        bodcasterImage: 'assets/png/talent2.JPG',
        id: 4,
        name: 'راديو المواهب ',
        enName: 'Talent Radio',
        subtitle: 'حيث اكتشاف المواهب الغنائية والعزف الموسيقي',
        enSubtitle: 'Discover New Musical Talent.',
        bodcaster: 'راديو المواهب الغنائية',
        image: 'assets/png/talent1.JPG',
        url: 'https://stream.app-seen.com/live/radio4.m3u8'),
  ];

  Rx<AudioPlayer?> player = Rx(null);
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // ever(channelId, (callback) {
    //   player.value?.dispose();
    //   init(radioList.firstWhere((element) => element.id == channelId.value).url)
    //       .then((value) {
    //     radioState.value = value;
    //   });
    // });
  }

  Future<bool> init(String url) async {
    if (await checkUrl(url)) {
      print('true ali true');
      player.value = AudioPlayer();
      player.value?.playingStream.listen((event) {
        isPlaying.value = event;
      });
      radioState.value = true;
      print(radioState.value);
      await player.value?.setUrl(url);
      player.value?.play();
      return true;
    } else {
      radioState.value = false;
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (player.value != null) {
      player.value?.dispose();
    }
  }

  RxDouble volumeLevel = 0.0.obs;
  RxDouble lastVolumeLevel = 0.0.obs;
  void changeVolume(double value) {
    volumeLevel.value = value;

    if (player.value != null) {
      player.value?.setVolume(value);
    }
  }

  void toggleMute() {
    if (volumeLevel.value == 0) {
      volumeLevel.value = lastVolumeLevel.value;
      if (player.value != null) {
        player.value?.setVolume(lastVolumeLevel.value);
      }
    } else {
      if (player.value != null) {
        player.value?.setVolume(0);
      }
      lastVolumeLevel.value = volumeLevel.value;
      volumeLevel.value = 0;
    }
  }

  void changeChannelIndex(int currentIndex) {
    channelId.value = currentIndex;
  }

  Future<bool> checkUrl(String url) async {
    try {
      return (await Dio().get(url)).statusCode == 404 ? false : true;
    } catch (e) {
      return false;
    }
  }

  void changeRadioChannel() {
    player.value?.pause();
    player.value?.dispose();
    player.value = null;
    radioState.value = false;
    init(radioList.firstWhere((element) => element.id == channelId.value).url)
        .then((value) {
      radioState.value = value;
    });
  }

  void disposePlayer() {
    player.value?.dispose();
    player.value = null;
  }
}
