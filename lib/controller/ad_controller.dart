import 'package:get/get.dart';
import 'package:seen/data/api/ads_api.dart';
import 'package:seen/data/model/ad.dart';

class AdController extends GetxController {
  RxList<Ad> ads = <Ad>[].obs;
  AdsApi adsApi = AdsApi();
  
  Future<void> getAds() async {
    ads.value = await adsApi.getAds() ?? [];
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAds();
  }
}
