import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/About.dart';
import 'package:taxi_app/HomePage.dart';
import 'package:taxi_app/Payments.dart';
import 'package:taxi_app/Rides.dart';
import 'package:taxi_app/Setting.dart';
import 'package:taxi_app/Wallet.dart';
import 'package:share/share.dart';

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
        actions: <Widget>[
          IconButton(
                onPressed: () => Share.share(
                    "Download the Taxi App and share with your friends.\nPlayStore -  " "https://play.google.com/store/apps"),
                icon: Icon(
                  Icons.share,
                  size: 20,
                ),
          ),
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Muhammad Saad"),
              accountEmail: new Text("Saadmuhamad@gmail.com"),
              currentAccountPicture:
                  new CircleAvatar(child: Icon(Icons.add_circle),
                  ),
                  
            ),
            new ListTile(
              title: new Text("Home"),
              trailing: new Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Payments"),
              trailing: new Icon(Icons.payment),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PaymentsPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Wallet"),
              trailing: new Icon(Icons.account_balance_wallet),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Walletpage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Free Rides"),
              trailing: new Icon(Icons.local_taxi),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RidesPage()));
              },
            ),
            new Divider(),
            new ListTile(
              title: new Text("Settings"),
              trailing: new Icon(Icons.settings),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              },
            ),
            new Divider(),
            new ListTile(),
            new ListTile(),
            new ListTile(),
            new Divider(),
            new ListTile(
              title: new Text("FAQ"),
              trailing: new Icon(
                Icons.priority_high,
              ),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            initialCameraPosition:
                CameraPosition(target: LatLng(12.92, 77.02), zoom: 20),
          )
        ],
      ),
    );
  }
}
