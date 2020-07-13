import 'package:flutter/material.dart';
import 'package:flutterapp/screens/LandingPage.dart';
import 'package:flutterapp/screens/register.dart';
import 'package:flutterapp/screens/wrapped.dart';
import 'package:flutterapp/services/auth.dart';

class Authenticate extends StatefulWidget {
  final bool out;

  const Authenticate({Key key, this.out}) : super(key: key);
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30),
                // margin: EdgeInsets.only(top: 250),
                decoration: BoxDecoration(),
                height: 500,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(top: 25),
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Color(0xffFDCF09),
                        child: CircleAvatar(
                          radius: 95,
                          backgroundImage: AssetImage('assets/logo.jpg'),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter email";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          cursorColor: Color(0xFFEF7532),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Color(0xFFEF7532),
                            ),
                            hintText: 'Enter Your E-mail ',
                            labelText: 'Email',
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
                    ),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return "please enter password";
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          cursorColor: Color(0xFFEF7532),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Color(0xFFEF7532),
                            ),
                            hintText: 'Enter Your Password',
                            labelText: 'Password',
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
                    ),
                    Expanded(
                      child: Container(
                        // padding: EdgeInsets.only(left: 35),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            RaisedButton(
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  dynamic result =
                                      await _auth.signIn(email, password);
                                  if (result == null) {
                                    final snackBar = SnackBar(
                                      content: Text(
                                        'Invalid Email or Password!',
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      backgroundColor: Colors.red,
                                    );

                                    _scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Wrapper()));
                                  }
                                }
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
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUp()));
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
                                'Singn up',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
