import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Taxi App"),
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Muhammad Saad"),
              accountEmail: new Text("Saadmuhamad@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                child: Image.asset('assets/image/wall.jpg'),
              ),
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Payments"),
              trailing: new Icon(Icons.payment),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Wallet"),
              trailing: new Icon(Icons.account_balance_wallet),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Free Rides"),
              trailing: new Icon(Icons.local_taxi),
            ),
            new Divider(),
            new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(12.92,77.02), zoom: 20),)
        ],
      ),
     
    );
  }
}