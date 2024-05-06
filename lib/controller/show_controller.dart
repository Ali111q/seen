import 'package:get/get.dart';
import 'package:seen/data/api/episode_api.dart';
import 'package:seen/data/api/show_api.dart';
import 'package:seen/data/model/episode.dart';

import '../data/model/show.dart';

class ShowController extends GetxController {
  ShowApi showApi = ShowApi();
  EpisodeApi episodeApi = EpisodeApi();
  RxInt seasonIndex = 0.obs;
  Rx<Show?> show = Rx(null);
  RxList<Episode> episodes = RxList([]);

  void getShow(int id) async {
    this.episodes.clear();
    show.value = null;
    show.value = await showApi.getShow(id);
    List<Episode>? episodes =
        await episodeApi.getEpisodes(show.value!.seasons![0].id);
    if (episodes != null) {
      this.episodes.value = episodes;
    }
  }

  void changeSeasonIndex(int index) {
    seasonIndex.value = index;
  }
}
