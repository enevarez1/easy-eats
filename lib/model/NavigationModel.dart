import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationItems = [
  NavigationModel(title: "Home", icon: Icons.home),
  NavigationModel(title: "Search", icon: Icons.search),
  NavigationModel(title: "Settings", icon: Icons.settings),
];
