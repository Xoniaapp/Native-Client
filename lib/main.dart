import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/home.dart';
import './pages/landing_page.dart';

bool showLandingPage = true;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    if (instance.containsKey('access-token') &&
        instance.containsKey('session-token')) {
      showLandingPage = false;
    }
    runApp(const App());
  });
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xonia',
      home: showLandingPage ? const LandingPage() : const HomePage(),
    );
  }
}
