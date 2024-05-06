import 'package:seen/data/model/ad.dart';
import 'package:seen/data/model/episode.dart';

import 'category.dart';
import 'show.dart';

class Home {
  List<Episode> banner;
  List<Category> categories;
  List<Ad> ads;
  Home({required this.banner, required this.categories, required this.ads});
  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      banner:
          List<Episode>.from(json['banner'].map((x) => Episode.fromJson(x))),
      categories: List<Category>.from(
          json['categories'].map((x) => Category.fromJson(x))),
      ads: List<Ad>.from(json['ads'].map((x) => Ad.fromJson(x))),
    );
  }
  Map toJson() {
    return {
      'banner': banner.map((e) => e.toJson()).toList(),
      'categories': categories.map((e) => e.toJson()).toList(),
    };
  }
}
