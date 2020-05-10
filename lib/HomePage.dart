import 'package:easy_eats/recipe/CreateRecipe.dart';
import 'package:easy_eats/recipe/Recipe.dart';
import 'package:easy_eats/recipe/SearchRecipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'model/NavigationModel.dart';

var recipes = <Recipe>[];

class HomePage extends StatefulWidget {
  Recipe currentRecipe;

  HomePage({this.currentRecipe}) {}

  @override
  _HomePageState createState() => _HomePageState(currentRecipe: currentRecipe);
}

class _HomePageState extends State<HomePage> {
  var username = "Username";
  var email = "utepstudent@miners.utep.edu";
  Recipe currentRecipe;

  _HomePageState({this.currentRecipe});

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
            accountName: Text(username),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS ? Colors.white : Colors.white,
              child: Text(
                username.substring(0, 1),
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
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => HomePage()));
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
              return Slidable(
                actionPane: SlidableDrawerActionPane(),
                secondaryActions: [
                  //option to delete
                  IconSlideAction(
                      caption: "Delete",
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        setState(() {
                          print(index);
                          recipes.removeAt(index);
                        });
                      }),
                ],
                child: ListTile(
                  title: Text('${recipes[index].recipeName}'),
                  subtitle: Text('${recipes[index].recipeDescription}'),
                  leading: null,
                  onTap: () {},
                ),
              );
            },
            itemCount: recipes.length,
          ),
        ],
      ),
    );
  }
}
