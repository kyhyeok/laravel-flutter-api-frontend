import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_api_frontend/screens/categories.dart';
import 'package:flutter_api_frontend/screens/login.dart';
import 'package:flutter_api_frontend/screens/register.dart';
import 'package:flutter_api_frontend/providers/CategoryProvider.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<CategoryProvider>(
            create: (context) => CategoryProvider()
          )
        ],
        child: MaterialApp(
        title: 'Welcome to Flutter',
        home: Login(),
        routes: {
          '/login': (context) => Login(),
          '/register': (context) => Register(),
          '/categories': (context) => Categories(),
        }
    ));
  }
}
