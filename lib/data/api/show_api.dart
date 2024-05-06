import '../../common/helper/api_helper.dart';
import '../model/show.dart';

class ShowApi extends ApiHelper<Show> {
  Future<Show?> getShow(int id) {
    return super.get('/show-show-by-id?id=$id', Show.fromJson);
  }

  Future<List<Show>?> searchShows(String search) {
    return super.getItems('/search?', Show.fromJson,
        query: {'search': search}, doubleData: true);
  }
}
