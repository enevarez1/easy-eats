import 'package:easy_eats/recipe/CreateRecipe.dart';
import 'package:easy_eats/recipe/Recipe.dart';
import 'package:easy_eats/recipe/SearchRecipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/NavigationModel.dart';

var recipes = <Recipe>[];
var _recipeListItems = [
  "Chicken",
  "Burrito",
  "Ice Cream",
  "Poptart",
  "Strudel",
  "Bacon",
  "Cheon",
  "Elsa",
  "Ben",
  "Apple",
  "Leslie",
  "Strawberries",
  "Cherries",
  "Salad",
  "Pizza",
  "Meatloaf"
];

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

var recipeIngredients = <String>["Step 1", "Step 2"];
var cheon = "My best friend";

class _HomePageState extends State<HomePage> {
  var recipeList = <Recipe>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateRecipe()));
        },
        backgroundColor: Colors.blue,
        icon: Icon(Icons.add),
        label: Text("Add"),
      ),
      drawer: Drawer(
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Username"),
            accountEmail: Text("utepstudent@miners.utep.edu"),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS ? Colors.white : Colors.white,
              child: Text(
                "A",
                style: TextStyle(fontSize: 40.0),
              ),
            ),
          ),
          Container(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: navigationItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('${navigationItems[index].title}'),
                  leading: Icon(navigationItems[index].icon),
                  onTap: () {
                    print(index);
                    switch (index) {
                      case 0:
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                        break;
                      case 1:
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => SearchRecipe()));
                        break;
                    }
                  },
                );
              },
            ),
          )
        ],
      )),
      appBar: AppBar(
        elevation: 8.0,
        backgroundColor: Colors.blue,
        title: Text("Easy Eats"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${_recipeListItems[index]}'),
                subtitle: Text('${_recipeListItems[index]}'),
                leading: null,
                onTap: () {},
              );
            },
            itemCount: _recipeListItems.length,
          ),
        ],
      ),
    );
  }
}
