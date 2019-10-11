import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_app/About.dart';
import 'package:taxi_app/HomePage.dart';
import 'package:taxi_app/Payments.dart';
import 'package:taxi_app/Rides.dart';
import 'package:taxi_app/Setting.dart';
import 'package:taxi_app/Wallet.dart';
import 'package:share/share.dart';
import 'package:taxi_app/google_map_request.dart';

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
  GoogleMapController mapController;
  GoogleMapService _googleMapServices = GoogleMapService();
  TextEditingController locationController = TextEditingController();
  TextEditingController destinationController = TextEditingController();
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = { };
  final Set<Polyline> _polyLines = { };

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? Container(
            alignment: Alignment.center,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Stack(
            children: <Widget>[
              GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: _initialPosition, zoom: 10),
                onMapCreated: onCreated,
                myLocationEnabled: true,
                mapType: MapType.normal,
                compassEnabled: true,
                markers: _markers,
                onCameraMove: _onCameraMove,
                polylines: _polyLines,
              ),
              Positioned(
                top: 50.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: locationController,
                    decoration: InputDecoration(
                      icon: Container(
                        margin: EdgeInsets.only(left: 20, top: 5),
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
                top: 105.0,
                right: 15.0,
                left: 15.0,
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.0),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 5.0),
                          blurRadius: 10,
                          spreadRadius: 3)
                    ],
                  ),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: destinationController,
                    textInputAction: TextInputAction.go,
                    onSubmitted: (value) {
                      sendRequest(value);
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

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    setState(() {
      _lastPosition = position.target;
    });
  }

  void _onMarkerPressed(LatLng location, String address) {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastPosition.toString()),
          position: location,
          infoWindow: InfoWindow(title: "Address", snippet: "Go here"),
          icon: BitmapDescriptor.defaultMarker));
    });
  }

  void createRoute(String encodedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId(_lastPosition.toString()),
          width: 10,
          points: convertToLatLng(decodePoly(encodedPoly)),
          color: Colors.teal));
    });
  }

  List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 1];
    print(lList.toString());
    return lList;
  }

  void _getUserLocation() async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      locationController.text = placemark[0].name;
    });
  }

  void sendRequest(String intendedLocation) async {
    List<Placemark> placemark =
        await Geolocator().placemarkFromAddress(intendedLocation);
    double latitude = placemark[0].position.latitude;
    double longitude = placemark[0].position.longitude;
    LatLng destination = LatLng(latitude, longitude);
    _onMarkerPressed(destination, intendedLocation);
    String route = await _googleMapServices.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
  }
}
