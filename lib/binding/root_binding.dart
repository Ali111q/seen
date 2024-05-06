import 'package:get/get.dart';
import 'package:seen/controller/ad_controller.dart';
import 'package:seen/controller/auth_controller.dart';
import 'package:seen/controller/navbar_controller.dart';
import 'package:seen/controller/radio_controller.dart';
import 'package:seen/controller/reel_controller.dart';
import 'package:seen/controller/show_controller.dart';

import '../controller/stream_controller.dart';

class RootBionding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ReelController());
    Get.lazyPut(() => ShowController());
    Get.lazyPut(() => RadioController());
    Get.lazyPut(() => AdController());
    Get.lazyPut(() => StreamController());
    Get.lazyPut(() => NavbarController());
  }
}
