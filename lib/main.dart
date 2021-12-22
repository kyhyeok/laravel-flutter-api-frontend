import 'package:flutter/material.dart';
import 'package:flutter_api_frontend/providers/AuthProvider.dart';
import 'package:flutter_api_frontend/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_api_frontend/screens/categories.dart';
import 'package:flutter_api_frontend/screens/login.dart';
import 'package:flutter_api_frontend/screens/register.dart';
import 'package:flutter_api_frontend/providers/CategoryProvider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider(authProvider)),
              ],
              child: MaterialApp(title: 'Welcome to Flutter', routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  if (authProvider.isAuthenticated) {
                    return Home();
                  } else {
                    return Login();
                  }
                },
                '/login': (context) => Login(),
                '/register': (context) => Register(),
                '/home': (context) => Home(),
                '/categories': (context) => Categories(),
              }));
        }));
  }
}
