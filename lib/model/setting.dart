import 'dart:io';

class Setting {
  final String? asia;
  final String? zain;
  final String? korek;
  final String? email;
  final String min_version;
  final String current_version;
  final String? ios_url;
  final String? android_url;

  Setting(
      {this.asia,
      this.zain,
      this.korek,
      this.email,
      required this.min_version,
      required this.current_version,
      this.ios_url,
      this.android_url});

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      min_version: Platform.isAndroid
          ? json['min_version_android']
          : json['min_version_ios'],
      current_version: Platform.isAndroid
          ? json['current_version_ios']
          : json['current_version_android'],
      zain: json['zain'],
      korek: json['korek'],
      email: json['email'],
      asia: json['asia'],
      ios_url: json['ios_url'],
      android_url: json['android_url'],
    );
  }
}
