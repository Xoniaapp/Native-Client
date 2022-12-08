import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './color_scheme.dart' as color_scheme;
import './pages/home.dart';
import './pages/sign_in.dart';

bool showLandingPage = true;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((instance) {
    if (instance.containsKey('access-token')) {
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

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_scheme.darkOne,
      body: Center(
        child: Column(
          children: <Widget>[
            Image.asset('assets/images/logo.png'),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignInPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: color_scheme.redOne,
              ),
              child: const Text('Sign in'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: color_scheme.darkOne,
                side: const BorderSide(
                  width: 2,
                  color: color_scheme.redOne,
                ),
              ),
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
