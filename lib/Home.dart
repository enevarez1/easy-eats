import 'package:easy_eats/Theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'commons/CollapsingNavigationDrawer.dart';

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: drawerBackgroundColor,
        title: Text("Easy Eats"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          //TODO Make this work with different pages, selection of pages will be where Container() is, We just relaunch this page constantly.
          Container(color: Colors.red),
          CollapsingNavigationDrawer()
        ],
      ),
    );
  }
}
