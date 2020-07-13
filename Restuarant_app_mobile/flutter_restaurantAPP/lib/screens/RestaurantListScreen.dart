import 'dart:convert';
import 'dart:ffi';
import 'package:flutterapp/screens/mapScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutterapp/screens/restaurantlist.dart';
import 'package:flutterapp/services/restaurantService.dart';
import 'descriptionScreen.dart';
import '../widjets/buttomBar.dart';
import '../widjets/card.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class RestaurantListScreen extends StatefulWidget {
  @override
  _RestaurantListScreenState createState() => _RestaurantListScreenState();
}

class _RestaurantListScreenState extends State<RestaurantListScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _tag;
  String _cat;
  List<dynamic> _category;
  List<dynamic> _restaurants;
  bool _isld = false;
  bool _isSelected = false;
  bool _isldd = false;
  String _testimg;
  @override
  void initState() {
    super.initState();
    getData();
    getRestaurant('Maroccain');
  }

  void getData() async {
    RestaurantService rs =
        RestaurantService("http://192.168.1.12:8080/categories");
    var categorys = await rs.getinfos();

    setState(() {
      _category = categorys["_embedded"]["categories"];
      _tabController = TabController(length: _category.length, vsync: this);
      _cat = _category[0]["name"];
      _isld = true;
    });
  }

  void getRestaurant(String c) async {
    RestaurantService rs1 =
        RestaurantService("http://192.168.1.12:8080/resName?cat=$c");
    var restaurants = await rs1.getinfos();
    _restaurants = restaurants;
    setState(() {
      _isldd = true;
    });
  }

  bool _load() {
    return _isld && _isldd;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _load() == false
          ? Container(
              color: Colors.white,
              child: SpinKitChasingDots(
                color: Color(0xFFEF7532),
                size: 50.0,
              ),
            )
          : Scaffold(
              backgroundColor: Color(0xFFfeeeec),
              appBar: AppBar(
                backgroundColor: Color(0xFFEF7532),
                elevation: 15,
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  iconSize: 35,
                  splashColor: Color(0xFFffd4c9),
                ),
                title: Text(
                  "Resturant App",
                  style: TextStyle(
                    fontFamily: 'Pom',
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                actions: <Widget>[
                  IconButton(
                      onPressed: () {
                        print(_cat);
                      },
                      icon: Icon(
                        Icons.restaurant,
                        color: Colors.white,
                      )),
                ],
                bottom: TabBar(
                    labelStyle: TextStyle(),
                    onTap: (value) async {
                      setState(() {
                        _cat = _category[value]["name"];
                        print(_cat);
                        getRestaurant(_cat);
                      });
                    },
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    isScrollable: true,
                    labelPadding: EdgeInsets.only(right: 45.0),
                    unselectedLabelColor: Colors.grey, //Color(0xFFCDCDCD)
                    tabs: _category
                        .map((dynamic S) => Container(
                              padding: EdgeInsets.only(left: 30, bottom: 6),
                              child: Text(
                                S["name"],
                                style: TextStyle(
                                  fontFamily: 'Pom',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ))
                        .toList()),
              ),
              body: TabBarView(
                  controller: _tabController,
                  children: _category
                      .map((e) => Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(left: 20),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: _restaurants.length,
                              itemBuilder: (context, index) {
                                return CardR(
                                  onTap: () {
                                    Navigator.of(context).push(PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 600),
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          Description(
                                        tag: _restaurants[index]["name"],
                                        imagePath:
                                            "http://192.168.1.12:8080/imageFilm/${_restaurants[index]['id']}",
                                        desc:
                                            "${_restaurants[index]['description']}",
                                        phone:
                                            "${_restaurants[index]['phone']}",
                                        name: "${_restaurants[index]['name']}",
                                        longitude: _restaurants[index]
                                            ['longitude'],
                                        latitude: _restaurants[index]
                                            ['latitude'],
                                      ),
                                      transitionsBuilder: (context, animation,
                                              secondaryAnimation, child) =>
                                          child,
                                    ));
                                  },
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MapTest(
                                          longitude: _restaurants[index]
                                              ['longitude'],
                                          latitude: _restaurants[index]
                                              ['latitude'],
                                        ),
                                      ),
                                    );
                                  },
                                  imagePath:
                                      "http://192.168.1.12:8080/imageFilm/${_restaurants[index]['id']}",
                                  adresse: "${_restaurants[index]['adresse']}",
                                  name: "${_restaurants[index]['name']}",
                                  tag: _restaurants[index]["name"],
                                );
                              })
                              ),
                              )
                      .toList()),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  print("----------------------------------------------------");
                  print(_restaurants);
                },
                backgroundColor: Color(0xFFEF7532),
                child: Icon(Icons.restaurant),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomBar(),
            ),
    );
  }
}

// Container(
//           color: Colors.white70,
//           child: _isld == false
//               ? Center(child: CircularProgressIndicator())
//               : ListView(

//                   padding: EdgeInsets.only(left: 20),
//                   children: <Widget>[
//                     SizedBox(height: 15.0),
//                     Text(
//                       "Categories",
//                       style: TextStyle(
//                           fontFamily: 'Pom',
//                           fontSize: 60,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     TabBar(
//                         onTap: (value) {
//                           setState(() {
//                             _cat = _category[value]["name"];
//                             print(_cat);
//                             getRestaurant();
//                           });
//                         },
//                         controller: _tabController,
//                         indicatorColor: Colors.transparent,
//                         labelColor: Color(0xFFC88D67),
//                         isScrollable: true,
//                         labelPadding: EdgeInsets.only(right: 45.0),
//                         unselectedLabelColor: Color(0xFFCDCDCD),
//                         tabs: _category
//                             .map((dynamic S) => Container(
//                                   padding: EdgeInsets.only(top: 8),
//                                   child: Text(
//                                     S["name"],
//                                     style: TextStyle(
//                                       fontFamily: 'Varela',
//                                       fontSize: 20.0,
//                                     ),
//                                   ),
//                                 ))
//                             .toList()),
//                   ],
//                 ),
//         ),
//---------------------------------------
// Column(
//           children: <Widget>[
//             Text(
//               "Categories",
//               style: TextStyle(
//                   fontFamily: 'Pom', fontSize: 60, fontWeight: FontWeight.bold),
//             ),
//             Expanded(
//               flex: 1,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _category.length,
//                 itemBuilder: (BuildContext context, int index) => InkWell(
//                   onTap: () {
//                     setState(() {
//                       _cat = _category[index]["name"];
//                       print(_cat);
//                     });
//                   },
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     child: Text(
//                       _category[index]["name"],
//                       style: TextStyle(
//                           fontFamily: 'Varela',
//                           fontSize: 20.0,
//                           color: Colors.amber),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               flex: 7,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: _restaurants.length,
//                 itemBuilder: (context, index) {
//                   return CardR(
//                     onTap: () {
//                       _tag = "${_restaurants[index]["name"]}";
//                       Navigator.of(context).push(PageRouteBuilder(
//                         transitionDuration: Duration(milliseconds: 600),
//                         pageBuilder: (context, animation, secondaryAnimation) =>
//                             Description(
//                           tag: _tag,
//                         ),
//                         transitionsBuilder:
//                             (context, animation, secondaryAnimation, child) =>
//                                 child,
//                       ));
//                     },
//                     onPressed: () {
//                       print("test");
//                     },
//                     imagePath: "assets/test2.jpg",
//                     adresse: "7 okba bno Nafii Casablaca",
//                     name: "Martin&Nills",
//                     tag: "${_restaurants[index]["name"]}",
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
