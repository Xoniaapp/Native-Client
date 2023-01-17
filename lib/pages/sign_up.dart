import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../color_scheme.dart' as color_scheme;
import '../api_stuff.dart' as api_stuff;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _infoIsError = false;
  String _info = '';
  final Map _reqBody = {'email': '', 'password': '', 'username': ''};

  void _signUp() async {
    setState(() {
      _infoIsError = false;
      _info = 'Signing up...';
    });
    var res = await http.post(api_stuff.uriForApiRoute('/auth/signup'),
        body: jsonEncode(_reqBody),
        headers: {'Content-Type': 'application/json'});
    if (res.statusCode == 201) {
      var decodedResponse = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      // TO-DO: Actually process the response instead of just printing it
      print(decodedResponse);
      return;
    }
    if (res.statusCode == 409) {
      setState(() {
        _infoIsError = true;
        _info = 'Your username and suffix combination is already used';
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
    setState(() {
      _infoIsError = false;
      _info = '';
    });
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
              child: Text('Sign up',
                  style: TextStyle(color: color_scheme.white, fontSize: 20)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (input) {
                    if (RegExp(
                            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                        .hasMatch(input)) {
                      setState(() {
                        _infoIsError = false;
                        _info = '';
                      });
                      _reqBody['email'] = input;
                    } else {
                      setState(() {
                        _infoIsError = true;
                        _info = 'Email must be a valid email';
                      });
                    }
                  },
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
              padding: const EdgeInsets.only(top: 6),
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (input) {
                    if (input.length < 6) {
                      setState(() {
                        _infoIsError = true;
                        _info =
                            'Password length must be more than or equal to 6 characters';
                      });
                    } else if (input.length > 64) {
                      setState(() {
                        _infoIsError = true;
                        _info =
                            'Password length must be less than or equal to 64 characters';
                      });
                    } else {
                      setState(() {
                        _infoIsError = false;
                        _info = '';
                      });
                      _reqBody['password'] = input;
                    }
                  },
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
              padding: const EdgeInsets.only(top: 6, bottom: 20),
              child: SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (input) {
                    if (input.length < 2) {
                      setState(() {
                        _infoIsError = true;
                        _info =
                            'Username length must be more than or equal to 2 characters';
                      });
                    } else if (input.length > 32) {
                      setState(() {
                        _infoIsError = true;
                        _info =
                            'Username length must be less than or equal to 32 characters';
                      });
                    } else {
                      setState(() {
                        _infoIsError = false;
                        _info = '';
                      });
                      _reqBody['username'] = input;
                    }
                  },
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
                    hintText: 'Username',
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
                        onPressed: _signUp,
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                color_scheme.redOne),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        color: color_scheme.redOne)))),
                        child: const Text('Sign up')),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            color_scheme.darkOne),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: const BorderSide(
                                        width: 2,
                                        color: color_scheme.redOne)))),
                    child: const Text('Go back'),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12, left: 12),
              child: Text(_info,
                  style: TextStyle(
                      color: _infoIsError
                          ? color_scheme.redOne
                          : color_scheme.white,
                      fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
