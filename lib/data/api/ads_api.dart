import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/ad.dart';

class AdsApi extends ApiHelper<Ad> {
  Future<List<Ad>?> getAds() async {
    return await super.getItems('/ads', Ad.fromJson, doubleData: true);
  }
}
