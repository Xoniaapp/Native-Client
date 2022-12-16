const String baseUrl = 'https://cbbe967eae45.in.ngrok.io';

Uri uriForApiRoute(String route) {
  return Uri.parse(baseUrl + route);
}
