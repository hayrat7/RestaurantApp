import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/user.dart';
import 'package:flutterapp/screens/wrapped.dart';
import 'package:flutterapp/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterapp/screens/mapScreen.dart';
import 'widjets/buttomBar.dart';
import 'screens/LandingPage.dart';

void main() => runApp(MyApp1());

class MyApp1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFfeeeec),
          body: Wrapper(),
        ),
      ),
    );
  }
}
