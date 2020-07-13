import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

import 'mapScreen.dart';

class Description extends StatelessWidget {
  final String tag;
  final String imagePath;
  final String desc;
  final double longitude;
  final double latitude;
  final String phone;

  final String name;
  const Description(
      {Key key,
      @required this.tag,
      this.imagePath,
      this.desc,
      this.phone,
      this.name,
      this.longitude,
      this.latitude})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Description'),
        backgroundColor: Color(0xFFEF7532),
      ),
      body: Hero(
        tag: tag,
        child: Material(
          child: Column(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  width: MediaQuery.of(context).size.width,
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
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Color(0xFFEF7532),
                    fontFamily: 'Cat',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 30, bottom: 10),
                    child: Text(
                      '+212 $phone',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.black87,
                        fontFamily: 'Cat',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          desc,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black87,
                          ),
                          //textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          maxLines: 6,
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 45,
                width: MediaQuery.of(context).size.width - 100,
                margin: EdgeInsets.only(bottom: 50),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MapTest(
                          longitude: longitude,
                          latitude: latitude,
                        ),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(
                      color: Color(0xFFEF7532),
                    ),
                  ),
                  splashColor: Color(0xFFEF7532),
                  textColor: Color(0xFFEF7532),
                  color: Colors.white,
                  child: Text(
                    'See Location',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
child: Hero(tag: tag,
child: SingleChildScrollView(

child: Container(
color: Color(0xFFEF7532),
child: Column(
mainAxisAlignment: MainAxisAlignment.start,
children: <Widget>[
Image(image: AssetImage('assets/test.jpg'),
),
Container(
margin: EdgeInsets.only(top: 10),
child: Text('Boka Chika',
style: TextStyle(
fontSize: 40.0,
color: Color(0xFFEF7532),
fontFamily: 'Cat',
fontWeight: FontWeight.bold,
),
),
),
],
),
),
),

),*/
