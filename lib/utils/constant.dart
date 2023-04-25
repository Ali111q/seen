const String url = 'http://192.168.12.196/api';
const String loginUrl = '${url}/login';
const String registerUrl = '${url}/register';

const String homeUrl = '${url}/home';
const String settingUrl = '${url}/setting';
String getEpisodeUrl(id) {
  return '${url}/shows/$id';
}
