const String url = 'http://app-seen.com/api';
const String loginUrl = '${url}/login';
const String registerUrl = '${url}/register';

const String homeUrl = '${url}/home';
const String settingUrl = '${url}/setting';
String getEpisodeUrl(id) {
  return '${url}/shows/$id';
}

const String reelsCatUrl = '${url}/reels-category';
String getReelByIdUrl(id) {
  return '${url}/reels?category_id=$id';
}

const String addInVideoUrl = '${url}/episode-ad';
const String getAdsUrl = '${url}/ads';
String getShowUrl(id, {episode}) {
  return '${url}/show-show-by-id?id=${id}&episode_id=${episode ?? ''}';
}

String getSeasonUrl(id) {
  return '${url}/episode_by_season_id?id=$id';
}

const String getCatsUrl = '${url}/categories';
