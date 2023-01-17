import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../color_scheme.dart' as color_scheme;
import '../api_stuff.dart' as api_stuff;

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // TO-DO: Migrate this code from old API logic to new API logic
  // TO-DO: Add validation to this form
  // TO-DO: Change button styles
  bool _infoIsError = false;
  String _info = '';
  final Map _reqBody = {'email': '', 'password': ''};

  void _signIn() async {
    setState(() {
      _infoIsError = false;
      _info = 'Signing in...';
    });
    var res = await http.post(api_stuff.uriForApiRoute('/account/login'),
        body: jsonEncode(_reqBody),
        headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 400) {
      var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      print(decodedResponse);
      setState(() {
        _infoIsError = true;
        _info = decodedResponse['errors'][0]['field'] +
            ' ' +
            decodedResponse['errors'][0]['message'];
      });
      return;
    }
    if (res.statusCode == 401) {
      setState(() {
        _infoIsError = true;
        _info = 'Incorrect credentials';
      });
      return;
    }
    if (res.statusCode == 500) {
      setState(() {
        _infoIsError = true;
        _info = 'Internal server error';
      });
      return;
    }
    print(res.headers['set-cookie']);
    setState(() => _info = '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color_scheme.darkOne,
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text('Sign in',
                  style: TextStyle(color: color_scheme.white, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (input) => _reqBody['email'] = input,
                  cursorColor: color_scheme.white,
                  style: const TextStyle(color: color_scheme.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: color_scheme.redOne,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      color: color_scheme.gray,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6, bottom: 20),
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (input) => _reqBody['password'] = input,
                  cursorColor: color_scheme.white,
                  obscureText: true,
                  style: const TextStyle(color: color_scheme.white),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: color_scheme.redOne,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password',
                    hintStyle: const TextStyle(
                      color: color_scheme.gray,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color_scheme.redOne,
                        ),
                        child: const Text('Sign in')),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color_scheme.darkOne,
                      side: const BorderSide(
                        width: 2,
                        color: color_scheme.redOne,
                      ),
                    ),
                    child: const Text('Go back'),
                  ),
                ],
              ),
            ),
            Text(_info,
                style: TextStyle(
                    color:
                        _infoIsError ? color_scheme.redOne : color_scheme.white,
                    fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
