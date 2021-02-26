import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class FeedScreen extends StatefulWidget {
  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  Widget _showStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueGrey[200],
            child: Icon(Icons.add, size: 30)),
        InkWell(
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/image5.jpg'),
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/image.jpg'),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/image2.jpg'),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/imag3.jpg'),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage('assets/image4.jpg'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
      ),
    );
  }
}
