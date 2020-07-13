import 'package:flutter/material.dart';
import 'package:flutterapp/screens/LandingPage.dart';
import 'package:flutterapp/screens/RestaurantListScreen.dart';
import 'package:flutterapp/screens/wrapped.dart';
import 'package:flutterapp/screens/search.dart';
import 'package:flutterapp/services/auth.dart';

class BottomBar extends StatelessWidget {
  final AuthService _auth = AuthService();

  bool out = true;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 10.0,
      color: Colors.transparent,
      elevation: 9.0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width / 2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LandingPage()));
                    },
                    enableFeedback: true,
                    color: Color(0xFFEF7532),
                  ),
                  IconButton(
                    icon: Icon(Icons.category),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantListScreen()));
                    },
                    enableFeedback: true,
                    color: Color(0xFFEF7532),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    enableFeedback: true,
                    color: Color(0xFFEF7532),
                  ),
                  IconButton(
                    icon: Icon(Icons.power_settings_new),
                    onPressed: () {
                      _auth.singOut();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Wrapper()));
                    },
                    enableFeedback: true,
                    color: Color(0xFFEF7532),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
