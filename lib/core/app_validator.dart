import 'package:get/get.dart';

class AppValidator {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'email_is_invalid'.tr;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'email_is_invalid'.tr;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'password_is_invalid'.tr;
    }
    if (value.length < 6) {
      return 'password_is_invalid'.tr;
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'fullname_is_invalid'.tr;
    }
    return null;
  }
}
