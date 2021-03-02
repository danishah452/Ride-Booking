import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ride_booking/ui/HomeScreen/home_screen.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  final _formKey = GlobalKey<FormState>();
  bool isButtonPressed = false;

  LocationData _currentPosition;
  String _address, _dateTime;
  GoogleMapController mapController;
  Marker marker;
  Location location = Location();

  GoogleMapController _controller;
  LatLng _initialcameraposition = LatLng(31.582045, 74.329376);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _controller;
    location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }

  Widget _addressFields() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: new TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your address";
                }
                return null;
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: new BorderSide(color: Colors.orange),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                filled: true,
                fillColor: Colors.grey.shade100,
                labelText: 'Address',
                prefixIcon:
                    const Icon(Icons.home_sharp, size: 25, color: Colors.orange),
                labelStyle: TextStyle(color: Colors.black45),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: new TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your locality";
                }
                return null;
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: new BorderSide(color: Colors.orange),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                filled: true,
                fillColor: Colors.grey.shade100,
                labelText: 'Locality',
                labelStyle: TextStyle(color: Colors.black45),
                prefixIcon: const Icon(Icons.streetview_sharp,
                    size: 25, color: Colors.orange),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: new TextFormField(
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Please enter your city";
                }
                return null;
              },
              decoration: new InputDecoration(
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(35),
                  borderSide: new BorderSide(color: Colors.orange),
                ),
                enabledBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                focusedBorder: const OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.orange, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(25))),
                filled: true,
                fillColor: Colors.grey.shade100,
                labelText: 'City',
                prefixIcon: const Icon(Icons.location_city_sharp,
                    size: 25, color: Colors.orange),
                labelStyle: TextStyle(color: Colors.black45),
                contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _processButton() {
    return InkWell(
      onTap: () {
        if (_formKey.currentState.validate()) {
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Processing Data')));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.55,
        padding: EdgeInsets.symmetric(vertical: 14),
        // alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.orange.shade700),
          color: Colors.yellow.shade800,
          borderRadius: BorderRadius.circular(35),
        ),
        child: Center(
          child: Text(
            'Save',
            style: TextStyle(
                color: Colors.white, fontSize: 19, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  Widget _optionButton() {
    return new ButtonBar(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new RaisedButton(
          color: Colors.orange.shade400,
          colorBrightness: Brightness.light,
          splashColor: Colors.yellow,
          child: new Text(
            'Home',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange.shade300),
              borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        ),
        new RaisedButton(
          color: Colors.orange.shade400,
          splashColor: Colors.yellow,
          colorBrightness: Brightness.light,
          child: new Text(
            'Office',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange.shade300),
              borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        ),
        new RaisedButton(
          color: Colors.orange.shade400,
          splashColor: Colors.yellow,
          colorBrightness: Brightness.light,
          child: new Text(
            'Camp',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.orange.shade300),
              borderRadius: BorderRadius.circular(15)),
          onPressed: () {},
          padding: EdgeInsets.symmetric(vertical: 23, horizontal: 20),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   leading: GestureDetector(
      //       onTap: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(builder: (context) => HomePage()),
      //         );
      //       },
      //       child: Icon(Icons.arrow_back_sharp, size: 25)),
      //   title: Text('Back'),
      //   automaticallyImplyLeading: false,
      //   actions: [],
      // ),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: size.height * 0.34,
              width: size.width,
              child: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialcameraposition, zoom: 15),
                mapType: MapType.normal,
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),
            ),
            Flexible(
              flex: 1,
              child: ListView(
                children: [
                  Column(
                    children: <Widget>[
                      _addressFields(),
                      SizedBox(height: size.height * 0.01),
                      _optionButton(),
                      SizedBox(height: size.height * 0.02),
                      _processButton()
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        // DateTime now = DateTime.now();
        // _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
        //     .then((value) {
        //   setState(() {
        //     _address = "${value.first.addressLine}";
        //   });
        // });
      });
    });
  }

// Future<List<Address>> _getAddress(double lat, double lang) async {
//   final coordinates = new Coordinates(lat, lang);
//   List<Address> add =
//       await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   return add;
// }
}
