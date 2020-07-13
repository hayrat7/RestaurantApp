import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapTest extends StatefulWidget {
  final double latitude;
  final double longitude;
  const MapTest({Key key, this.latitude, this.longitude}) : super(key: key);

  @override
  _MapTestState createState() => _MapTestState(this.longitude, this.latitude);
}

class _MapTestState extends State<MapTest> {
  Set<Marker> _markers = HashSet<Marker>();
  GoogleMapController _mapController;
  BitmapDescriptor _markerIcon;
  final double longitude;
  final double latitude;

  _MapTestState(this.longitude, this.latitude);
  @override
  void initState() {
    super.initState();
    setMarkerIcon();
  }

  void setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(10, 10)), 'assets/marker.png');
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('myMarker'),
          position: LatLng(longitude, latitude),
          infoWindow: InfoWindow(
            title: 'Restaurant Name',
            snippet: 'welcome to our awesome restaurant',
          ),
          icon: _markerIcon,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFEF7532),
          elevation: 15,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
              onPressed: () {
                 Navigator.pop(context);
              }),
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
        body: GoogleMap(
          myLocationButtonEnabled: true,
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: LatLng(longitude, latitude),
            zoom: 12,
          ),
          markers: _markers,
        ),
      ),
    );
  }
}
