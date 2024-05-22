import 'package:seen/common/helper/api_helper.dart';
import 'package:seen/data/model/setting.dart';

class SettingApi extends ApiHelper<Setting> {
  Future<Setting?> getSetting() {
    return super.get('/setting', Setting.fromJson);
  }
}
