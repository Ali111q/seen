import 'package:seen/data/model/home.dart';

import '../../common/helper/api_helper.dart';

class HomeApi extends ApiHelper<Home> {
  Future<Home?> getHome() async {
    return await super.get('/home', Home.fromJson);
  }
}
