const String baseUrl = 'http://localhost:8080';

Uri uriForApiRoute(String route) {
  return Uri.parse(baseUrl + route);
}
