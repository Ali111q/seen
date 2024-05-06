import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/reel.dart';

class ReelApi extends ApiHelper<Reel> {
  Future<List<Reel>?> getReelCats() {
    return super.getItems('/reels-category', Reel.fromJson, doubleData: true);
  }
}
