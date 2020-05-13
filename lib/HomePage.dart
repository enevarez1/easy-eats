import "dart:math";

import 'package:easy_eats/RecipeDBWorker.dart';
import 'package:easy_eats/recipe/CreateRecipe.dart';
import 'package:easy_eats/recipe/Recipe.dart';
import 'package:easy_eats/recipe/SearchRecipe.dart';
import 'package:easy_eats/recipe/ViewRecipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'model/NavigationModel.dart';

List recipes = [];
//var recipes = <Recipe>[];

class HomePage extends StatefulWidget {
  HomePage();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var username = "Username";
  var email = "utepstudent@miners.utep.edu";
  var currentRecipe;

  _HomePageState();

  @override
  Widget build(BuildContext context) {
    loadData();
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          currentRecipe = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateRecipe()),
          );
          setState(() {
            if (currentRecipe != null) {
              recipes.add(currentRecipe);
            }
          });
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
                    Navigator.pop(context);
                    switch (index) {
                      case 0:
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchRecipe(
                                      recipes: recipes,
                                    )));
                        break;
                      case 1:
                        final _random = new Random();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewRecipe(
                                    currentRecipe: recipes[_random.nextInt(recipes.length)])));
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
      body: ListView.builder(
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
                      recipes.removeAt(index);
                    });
                  }),
            ],
            child: ListTile(
              title: Text('${recipes[index].recipeName}'),
              subtitle: Text('${recipes[index].recipeDescription}'),
              leading: null,
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewRecipe(currentRecipe: recipes[index])));
              },
            ),
          );
        },
        itemCount: recipes.length,
      ),
    );
  }
}
void loadData() async {
  debugPrint("loadData() called");
    recipes = await RecipeDBWorker.db.getAll();
}
