import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;

  NavigationModel({this.title, this.icon});
}

List<NavigationModel> navigationIItems = [
  NavigationModel(title: "Search", icon: Icons.search),
  NavigationModel(title: "Random Recipe", icon: Icons.sync),
];
