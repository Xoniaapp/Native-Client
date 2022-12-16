import 'package:flutter/material.dart';
import '../color_scheme.dart' as color_scheme;
import './sign_in.dart';
import './sign_up.dart';

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
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              ),
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
