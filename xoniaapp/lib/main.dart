import 'package:flutter/material.dart';
import './color_scheme.dart' as color_scheme;

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Xonia',
      home: LandingPage(),
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
              onPressed: () {},
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
