import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:seen/data/api/home_api.dart';
import 'package:seen/data/api/show_api.dart';
import 'package:seen/data/model/home.dart';

import '../data/model/show.dart';

class HomeController extends GetxController {
  HomeApi homeApi = HomeApi();
  ShowApi showApi = ShowApi();
  RxInt bannerIndex = 0.obs;
  Rx<Home?> home = Rx(null);
  RxList<Show> searchItems = RxList();
  RxString searchValue = RxString('');
  void setBannerIndex(int index) {
    bannerIndex.value = index;
  }

  @override
  void onInit() async {
    home.value = null;
    // TODO: implement onInit
    print('object');
    super.onInit();
    debounce(searchValue, (callback) {
      search(searchValue.value);
    });
    await getHome();
    print(home.value);
  }

  Future<void> getHome() async {
    home.value = await homeApi.getHome();
  }

  void search(String search) async {
    searchItems.value = await showApi.searchShows(search) ?? [];
  }

  void changeSearchValue(String search) {
    searchValue.value = search;
  }
}
