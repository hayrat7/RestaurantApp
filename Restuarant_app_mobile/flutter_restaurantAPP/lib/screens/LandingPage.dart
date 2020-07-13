import 'package:flutter/material.dart';
import 'package:flutterapp/services/restaurantService.dart';
import 'package:flutterapp/widjets/buttomBar.dart';
import 'RestaurantListScreen.dart';
import '../widjets/cardLanding.dart';
import 'RestaurantForm.dart';

class LandingPage extends StatelessWidget {
  List<dynamic> _category;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
          child: Column(
            children: <Widget>[
              SizedBox(height: 5.0),
              Container(
                height: 50,
                child: Text(
                  'Welcome',
                  style: TextStyle(
                      fontSize: 45.0,
                      fontFamily: 'Sacramento',
                      color: Color(0xFFEF7532),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20, bottom: 10),
                child: CardL(
                    imagePath: 'assets/client1.jpg',
                    type: "Clients",
                    desc: 'Find Your Best Restaurant',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantListScreen()));
                    }),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: CardL(
                    imagePath: 'assets/owner.jpg',
                    type: "Owner",
                    desc: 'Add Your Restaurant,Get More Clients',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RestaurantForm()));
                    }),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color(0xFFEF7532),
          child: Icon(Icons.restaurant),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
