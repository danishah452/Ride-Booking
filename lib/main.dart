import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ride_booking/ui/BottomNavigationScreens/Dashboard/dashboard_main.dart';
import 'package:ride_booking/ui/DrawerScreens/MyBike/vehicle.dart';
import 'package:ride_booking/ui/DrawerScreens/profile.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ride_booking/ui/DrawerScreens/my_address.dart';
import 'package:ride_booking/ui/HomeScreen/home_screen.dart';
import 'package:ride_booking/ui/LoginScreen/google%20_auth.dart';
import 'package:ride_booking/ui/LoginScreen/login_screen.dart';
import 'package:ride_booking/ui/LoginScreen/otp_verification.dart';
import 'package:ride_booking/ui/SplashScreen/splash_screen.dart';

void main() => runApp(MyApp());
//
// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(),
//       ),
//     );


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      // locale: DevicePreview.locale(context),
      // builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.purple),
      home: SplashScreen()
    );
  }
}
