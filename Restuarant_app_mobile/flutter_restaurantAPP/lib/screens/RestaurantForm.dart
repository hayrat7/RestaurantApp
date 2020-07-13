import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutterapp/services/LocationService.dart';
import '../widjets/buttomBar.dart';

import 'package:shared_preferences/shared_preferences.dart';

class RestaurantForm extends StatefulWidget {
  @override
  _RestaurantFormState createState() => _RestaurantFormState();
}

class _RestaurantFormState extends State<RestaurantForm> {
  String imageString;
  final _nameController = TextEditingController();
  final _adresseController = TextEditingController();
  final _descController = TextEditingController();
  final _phoneController = TextEditingController();
  final _catController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Io.File _image;
  double _longitude;
  double _latitude;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  bool _autoValidation = false;

  String _category;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future getLocation() async {
    LocationService locationService = LocationService();
    var _locationData = await locationService.getLocationData();
    _longitude = _locationData.longitude;
    _latitude = _locationData.latitude;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _adresseController.dispose();
    _descController.dispose();
    _phoneController.dispose();
    _catController.dispose();

    super.dispose();
  }

  void clear() {
    _nameController.text = '';
    _adresseController.text = '';
    _descController.text = '';
    _phoneController.text = '';
    _catController.text = '';
  }

  Future getImage() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    // Io.Directory directory = await getApplicationDocumentsDirectory();
    // final String path = directory.path;
    // _path = path;
    // var fileName = basename(image.path);
    // final Io.File localImage = await image.copy('$path/$fileName');

    setState(() {
      _image = image;
      // Io.File(pickedFile.path)
    });
  }

  Future getImageFromCamera() async {
    // ignore: deprecated_member_use
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    // Io.Directory directory = await getApplicationDocumentsDirectory();
    // final String path = directory.path;
    // //var fileName = basename(image.path);
    // final Io.File localImage = await image.copy('$path/$test');

    setState(() {
      _image = image;
      // Io.File(pickedFile.path)
    });
  }

  String imageToString() {
    final bytes = Io.File(_image.path).readAsBytesSync();

    String img64 = base64Encode(bytes);
    return img64;
    // imageString = img64;
    // print(img64);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: false,
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
                  print(_longitude);
                  print(_latitude);
                },
                icon: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                )),
          ],
        ),
        body: SingleChildScrollView(
          reverse: true,
          padding: EdgeInsets.all(18),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 170),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.image,
                            color: Color(0xFFEF7532),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(bottom: 5, left: 5),
                          child: Text(
                            'image',
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blueGrey,
                                fontFamily: 'Pom',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 100),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Color(0xFFEF7532),
                        size: 30,
                      ),
                      onPressed: getImageFromCamera,
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.only(left: 2),
                    child: IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Color(0xFFEF7532),
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          _image = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: getImage,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFfeeeec),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  margin: EdgeInsets.only(bottom: 10),
                  height: 180,
                  width: MediaQuery.of(context).size.width / 1 - 20,
                  child: _image == null
                      ? Icon(
                          Icons.add_photo_alternate,
                          color: Color(0xFFEF7532),
                          size: 50,
                        )
                      : ClipRRect(
                          child: Image.file(
                            _image,
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: TextFormField(
                        controller: _nameController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Color(0xFFEF7532),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.restaurant,
                            color: Color(0xFFEF7532),
                          ),
                          hintText: 'Enter The Name Of Your Restaurant',
                          labelText: 'Name',
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: TextFormField(
                        controller: _phoneController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Color(0xFFEF7532),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.phone,
                            color: Color(0xFFEF7532),
                          ),
                          hintText: 'Enter Your Phone Number',
                          labelText: 'Tel',
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: TextFormField(
                        controller: _adresseController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Color(0xFFEF7532),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.location_on,
                            color: Color(0xFFEF7532),
                          ),
                          hintText: 'Enter The Adresse Of Your Restaurant',
                          labelText: 'Adresse',
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: TextFormField(
                        controller: _catController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Color(0xFFEF7532),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.category,
                            color: Color(0xFFEF7532),
                          ),
                          hintText: 'Enter a Category of Your Restaurant',
                          labelText: 'Categorie',
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
                    Container(
                      margin: EdgeInsets.only(bottom: 10, top: 5),
                      child: TextFormField(
                        controller: _descController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        cursorColor: Color(0xFFEF7532),
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.description,
                            color: Color(0xFFEF7532),
                          ),
                          hintText: 'Enter A Description For Your Restaurant',
                          labelText: 'Description',
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
                  ],
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final form = _formKey.currentState;
            if (form.validate()) {
              http.post(
                  "http://192.168.1.12:8080/addRestaurant?name=${_nameController.text}&adresse=${_adresseController.text}&desc=${_descController.text}&phone=${_phoneController.text}&photo=${_nameController.text}&lon=$_latitude&lat=$_longitude&cat=${_catController.text}");
            }
            setState(() {
              _image = null;
              clear();
            });
          },
          backgroundColor: Color(0xFFEF7532),
          child: Icon(
            Icons.check_circle,
            size: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomBar(),
      ),
    );
  }
}
/*
TextFormField(
cursorColor: Color(0xFFEF7532),
decoration: InputDecoration(
icon:  Icon(Icons.category,
color: Color(0xFFEF7532),
),
hintText: 'Enter The Category Of Your Restaurant',
labelText: 'Category',
labelStyle: TextStyle(
color: Colors.blueGrey,
fontSize: 25.0,
fontFamily: 'Pom',
fontWeight: FontWeight.bold
),
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
),*/
