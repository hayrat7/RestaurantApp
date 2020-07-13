import 'package:flutter/material.dart';



class CardL extends StatelessWidget {


  CardL({ this.imagePath,  this.onTap, this.type, this.desc});


  final String imagePath;
  final String type;
  final String desc;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(25.0),
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
                bottomRight: Radius.circular(25.0),
              )
          ),
          elevation:10.0 ,
          margin: EdgeInsets.only(right: 20.0,top: 15.0),
            //onTap:  Navigator.push(context, MaterialPageRoute(builder: (context)=>RestaurantListScreen(tabController: tabController,)));,
            child: Container(

              width: MediaQuery.of(context).size.width/1-20,
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
                      child: Image(image: AssetImage("$imagePath"),
                        width:MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width:MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20.0),
                              bottomLeft: Radius.circular(20.0)
                          ),

                          color: Colors.white70

                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("$type",
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily:'Pom',
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFEF7532),
                                  ),),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("$desc",
                                  style: TextStyle(
                                      fontSize: 25.0,

                                      fontFamily: 'Cat',
                                      fontWeight: FontWeight.bold
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
    );
  }
}