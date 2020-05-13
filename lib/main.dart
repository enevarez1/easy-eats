import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import "utils.dart" as utils;
import 'HomePage.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();

  print("## main(): FlutterBook Starting");

  startMeUp() async {
    Directory docsDir = await getApplicationDocumentsDirectory();
    utils.docsDir = docsDir;
    runApp(Home());
  }

  startMeUp();

}

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
