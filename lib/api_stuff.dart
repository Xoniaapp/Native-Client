const String baseUrl = 'http://192.168.0.147:8080';

Uri uriForApiRoute(String route) {
  return Uri.parse(baseUrl + route);
}
