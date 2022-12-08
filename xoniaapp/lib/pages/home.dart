import 'package:flutter/material.dart';
import '../color_scheme.dart' as color_scheme;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_scheme.darkOne,
      body: Center(
        child: Column(
          children: const <Widget>[
            Text('home'),
          ],
        ),
      ),
    );
  }
}
