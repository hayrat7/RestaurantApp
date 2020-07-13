import 'package:flutter/material.dart';
import 'package:flutterapp/services/restaurantService.dart';
import 'package:flutterapp/widjets/buttomBar.dart';
import 'package:flutterapp/widjets/card.dart';
import 'package:http/http.dart' as http;
import 'descriptionScreen.dart';
import 'mapScreen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<dynamic> _restaurants;
  String _keyWord = '';
  Future getRestaurant(String c) async {
    RestaurantService rs1 =
        RestaurantService("http://192.168.1.12:8080/restaurantByName?name=$c");
    var restaurants = await rs1.getinfos();
    _restaurants = restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0xFFEF7532),
        elevation: 15,
        centerTitle: true,
        title: Text(
          "Restaurant App",
          style: TextStyle(
            fontFamily: 'Pom',
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.restaurant,
                color: Colors.white,
              )),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: TextFormField(
                      onChanged: (value) {
                        _keyWord = value;
                      },
                      cursorColor: Color(0xFFEF7532),
                      decoration: InputDecoration(
                        hintText: 'Enter a name of Restaurant',
                        labelText: 'Search',
                        labelStyle: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 25.0,
                            fontFamily: 'Pom',
                            fontWeight: FontWeight.bold),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEF7532),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFEF7532),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Color(0xFFEF7532),
                          size: 35,
                        ),
                        onPressed: () async {
                          await getRestaurant(_keyWord);
                        }),
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: _restaurants == null
                    ? Text("Search for a Restaurant")
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: _restaurants.length,
                        itemBuilder: (context, index) {
                          return CardR(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 600),
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        Description(
                                  tag: _restaurants[index]["name"],
                                  imagePath:
                                      "http://192.168.1.12:8080/imageFilm/${_restaurants[index]['id']}",
                                  desc: "${_restaurants[index]['description']}",
                                  phone: "${_restaurants[index]['phone']}",
                                  name: "${_restaurants[index]['name']}",
                                  longitude: _restaurants[index]['longitude'],
                                  latitude: _restaurants[index]['latitude'],
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
                                    longitude: _restaurants[index]['longitude'],
                                    latitude: _restaurants[index]['latitude'],
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
                        })),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("----------------------------------------------------");
          print(_restaurants);
        },
        backgroundColor: Color(0xFFEF7532),
        child: Icon(Icons.restaurant),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar(),
    );
  }
}
