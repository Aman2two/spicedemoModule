import 'package:demo_spice/Models/controller.dart';
import 'package:demo_spice/screens/main_screen.dart';
import 'package:demo_spice/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'utils/widget_util.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Provider is used for state management
    return ChangeNotifierProvider(
      create: (BuildContext context) => ItemController(),
      child: MaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColorDark: Colors.white,
        ),
        home: ItemsPage(),
      ),
    );
  }
}
