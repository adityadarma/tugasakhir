import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iot/login.dart';
import 'package:iot/home.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeMoRi',
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.lightBlue,
      // ),
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
      FirebaseAuth.instance
        .currentUser()
        .then((currentUser) => {
              if (currentUser == null)
                {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) {
                      return Login();
                    }),
                  )
                }
              else
                {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) {
                      return Home();
                    }),
                  )
                }
            })
        .catchError((err) => print(err));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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