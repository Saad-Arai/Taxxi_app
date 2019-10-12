import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taxi_app/Home.dart';
import 'package:taxi_app/state.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

  return runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(
        value: StateApp(),
      )
    ],
    child: TaxiApp(),
  ));
}

class TaxiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Taxi App',
      theme: new ThemeData(
          primarySwatch: Colors.teal,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null),
      home: new HomePage(),
    );
  }
}
