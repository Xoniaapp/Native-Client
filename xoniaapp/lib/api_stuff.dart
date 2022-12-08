const String baseUrl = 'https://gateway.xoniaapp.com/api';

Uri uriForApiRoute(String route) {
  return Uri.parse(baseUrl + route);
}
