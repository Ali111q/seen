class Setting {
  Setting({
    required this.asia,
    required this.zain,
    required this.korek,
    required this.email,
    required this.minVersionIos,
    required this.currentVersionIos,
    required this.minVersionAndroid,
    required this.currentVersionAndroid,
    required this.iosUrl,
    required this.androidUrl,
  });

  final String? asia;
  final String? zain;
  final String? korek;
  final String? email;
  final String? minVersionIos;
  final String? currentVersionIos;
  final String? minVersionAndroid;
  final String? currentVersionAndroid;
  final String iosUrl;
  final String androidUrl;

  Setting copyWith({
    String? asia,
    String? zain,
    String? korek,
    String? email,
    String? minVersionIos,
    String? currentVersionIos,
    String? minVersionAndroid,
    String? currentVersionAndroid,
    String? iosUrl,
    String? androidUrl,
  }) {
    return Setting(
      asia: asia ?? this.asia,
      zain: zain ?? this.zain,
      korek: korek ?? this.korek,
      email: email ?? this.email,
      minVersionIos: minVersionIos ?? this.minVersionIos,
      currentVersionIos: currentVersionIos ?? this.currentVersionIos,
      minVersionAndroid: minVersionAndroid ?? this.minVersionAndroid,
      currentVersionAndroid:
          currentVersionAndroid ?? this.currentVersionAndroid,
      iosUrl: iosUrl ?? this.iosUrl,
      androidUrl: androidUrl ?? this.androidUrl,
    );
  }

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      asia: json["asia"],
      zain: json["zain"],
      korek: json["korek"],
      email: json["email"],
      minVersionIos: json["min_version_ios"],
      currentVersionIos: json["current_version_ios"],
      minVersionAndroid: json["min_version_android"],
      currentVersionAndroid: json["current_version_android"],
      iosUrl: json["ios_url"],
      androidUrl: json["android_url"],
    );
  }

  Map<String, dynamic> toJson() => {
        "asia": asia,
        "zain": zain,
        "korek": korek,
        "email": email,
        "min_version_ios": minVersionIos,
        "current_version_ios": currentVersionIos,
        "min_version_android": minVersionAndroid,
        "current_version_android": currentVersionAndroid,
        "ios_url": iosUrl,
        "android_url": androidUrl,
      };

  @override
  String toString() {
    return "$asia, $zain, $korek, $email, $minVersionIos, $currentVersionIos, $minVersionAndroid, $currentVersionAndroid, $iosUrl, $androidUrl, ";
  }
}
