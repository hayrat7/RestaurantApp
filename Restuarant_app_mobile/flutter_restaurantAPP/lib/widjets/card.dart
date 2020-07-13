import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardR extends StatelessWidget {
  CardR(
      {this.onTap,
      this.imagePath,
      this.adresse,
      this.name,
      this.onPressed,
      this.tag});

  final Function onTap;
  final Function onPressed;
  final String imagePath;
  final String adresse;
  final String name;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(25.0),
            topLeft: Radius.circular(25.0),
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
        elevation: 10.0,
        margin: EdgeInsets.only(right: 20.0, top: 15.0),
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: onTap,
          child: Hero(
            tag: tag,
            child: Container(
              width: MediaQuery.of(context).size.width / 1 - 20,
              height: 250,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                        imageUrl: imagePath,
                        placeholder: (context, url) => SpinKitChasingDots(
                          color: Color(0xFFEF7532),
                          size: 50.0,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)),
                          // color: Color.fromRGBO(237, 184, 121,200),
                          color: Colors.white70),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  adresse,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'Pom',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 40),
                                    child: Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 30.0,
                                        color: Color(0xFFEF7532),
                                        fontFamily: 'Cat',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Material(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                    child: InkWell(
                                      enableFeedback: true,
                                      onTap: onPressed,
                                      child: Icon(
                                        Icons.map,
                                        size: 35,
                                        color: Color(0xFFEF7532),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
