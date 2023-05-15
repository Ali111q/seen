const String url = 'http://app-seen.com/api';
const String loginUrl = '$url/login';
const String registerUrl = '$url/register';

const String homeUrl = '$url/home';
const String settingUrl = '$url/setting';
String getEpisodeUrl(id) {
  return '$url/shows/$id';
}

const String reelsCatUrl = '$url/reels-category';
String getReelByIdUrl(id) {
  return '$url/reels?category_id=$id';
}

const String addInVideoUrl = '$url/episode-ad';
const String getAdsUrl = '$url/ads';
String getShowUrl(id, {episode}) {
  return '$url/show-show-by-id?id=$id&episode_id=${episode ?? ''}';
}

String getSeasonUrl(id) {
  return '$url/episode_by_season_id?id=$id';
}

const String getCatsUrl = '$url/categories';
String CommentsUrl(id) => '$url/reels-comment?reel_id=$id';
String viewUrl(id) => '$url/view?reel_id=$id';
const String logoutUrl = '$url/logout';
const String commentUrl = '$url/comment';
String likeUrl(id) => '$url/like?reel_id=$id';
const String loginCheckUrl = '$url/check-login';
String searchUrl(String? search) => '$url/search?search=${search ?? ''}';
const String editProfileUrl = '$url/update';
