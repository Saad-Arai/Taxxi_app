import 'package:flutter/material.dart';
import 'package:taxi_app/Home.dart';

void main() => runApp(TaxiApp());

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: HomePage(title: 'Taxi App'),
    );
      
    
  }
}
