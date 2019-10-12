import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxi_app/About.dart';
import 'package:taxi_app/HomePage.dart';
import 'package:taxi_app/Payments.dart';
import 'package:taxi_app/Rides.dart';
import 'package:taxi_app/Setting.dart';
import 'package:taxi_app/Wallet.dart';
import 'package:share/share.dart';
import 'package:taxi_app/state.dart';

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
                  "Download the Taxi App and share with your friends.\nPlayStore -  "
                  "https://play.google.com/store/apps"),
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
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: ExactAssetImage('assets/image/wall.jpg'),
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
        body: Map());
  }
}

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Stateapp = Provider.of<StateApp>(context);

    return Stateapp.initialPosition == null
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: Stateapp.initialPosition, zoom: 10),
                onMapCreated: Stateapp.onCreated,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                //myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                markers: Stateapp.markers,
                onCameraMove: Stateapp.onCameraMove,
                polylines: Stateapp.polylines,
              ),
              Positioned(
                top: 49.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 4)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: Stateapp.destinationController,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 3),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "pick up",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 115.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 4)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: Stateapp.destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      Stateapp.sendRequest(value);
                    },
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
                        width: 10,
                        height: 10,
                        child: Icon(
                          Icons.local_taxi,
                          color: Colors.black,
                        ),
                      ),
                      hintText: "destination?",
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 15.0, top: 16.0),
                    ),
                  ),
                ),
              ),
              /* Positioned(
                                                top: 40,
                                                right: 10,
                                                child: FloatingActionButton(onPressed: _onMarkerPressed, tooltip: "Add Marker",
                                                backgroundColor: darkBlue,
                                                child: Icon(Icons.add_location, color: white,),
                                                ),
                                                                                          )*/
            ],
          );
  }
}
