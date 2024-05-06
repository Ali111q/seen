import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/reel.dart';

class ReelVideoApi extends ApiHelper<ReelVideo> {
  Future<List<ReelVideo>?> getReels(int id) {
    return super
        .getItems('/reels', ReelVideo.fromJson, doubleData: true, query: {
      'category_id': id,
    });
  }
}
