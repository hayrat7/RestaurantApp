import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/model/user.dart';
import 'package:flutterapp/screens/LandingPage.dart';
import 'package:flutterapp/screens/authenticade.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    if (user == null) {
      return Authenticate();
    } else {
      return LandingPage();
    }
  }
}
