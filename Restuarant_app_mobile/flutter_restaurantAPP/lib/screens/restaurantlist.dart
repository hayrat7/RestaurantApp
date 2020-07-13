import 'package:flutter/material.dart';
import 'package:flutterapp/widjets/card.dart';

import 'descriptionScreen.dart';

class RestaurantGenre extends StatefulWidget {
  final List _restaurants;

  final String _tag;

  RestaurantGenre(this._restaurants, this._tag);

  @override
  _RestaurantGenreState createState() =>
      _RestaurantGenreState(this._restaurants, this._tag);
}

class _RestaurantGenreState extends State<RestaurantGenre> {
  final List<dynamic> _restaurants;

  final String _tag;

  _RestaurantGenreState(this._restaurants, this._tag);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: _restaurants.length,
        itemBuilder: (context, index) {
          return CardR(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 600),
                pageBuilder: (context, animation, secondaryAnimation) =>
                    Description(
                  tag: _tag,
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) => child,
              ));
            },
            onPressed: () {
              print("test");
            },
            imagePath: "assets/test2.jpg",
            adresse: "7 okba bno Nafii Casablaca",
            name: "Martin&Nills",
            tag: _tag,
          );
        });
  }
}
// "${_restaurants[index]["name"]}"
