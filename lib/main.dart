import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/screens/categories.dart';
import 'package:flutter_api_frontend/screens/login.dart';
import 'package:flutter_api_frontend/screens/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Login(),
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
        '/categories': (context) => Categories(),
      }
    );
  }
}
