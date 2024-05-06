import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/episode.dart';

class EpisodeApi extends ApiHelper<Episode> {
  Future<List<Episode>?> getEpisodes(int id) async {
    return await super.getItems(
        '/episode_by_season_id?id=$id', Episode.fromJson,
        doubleData: true);
  }
}
