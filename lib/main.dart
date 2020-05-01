import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:iot/login.dart';
import 'package:iot/page.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MEMORI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(canvasColor: Colors.white, primarySwatch: Colors.red),
      home: Splashscreen(),
    );
  }
}

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, () async {
      final prefs = await SharedPreferences.getInstance();
      bool loginStatus = prefs.getBool('login') ?? false;
      if (loginStatus) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return Page();
          }),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) {
            return Login();
          }),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 150.0,
          height: 150.0,
          ),
      ),
    );
  }
}