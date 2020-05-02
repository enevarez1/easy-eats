import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Theme.dart';

class CreateRecipe extends StatefulWidget {
  _CreateRecipeState createState() => _CreateRecipeState();
}

class Item {
  const Item(this.time);

  final String time;
}

TextStyle style = TextStyle(color: Colors.white);

List<Item> users = <Item>[
  const Item(
    '5 minutes',
  ),
  const Item(
    '10 minutes',
  ),
  const Item(
    '15 minutes',
  ),
  const Item(
    '20 minutes',
  ),
  const Item(
    '25 minutes',
  ),
  const Item(
    '30 minutes',
  ),
  const Item(
    '35 minutes',
  ),
  const Item(
    '40 minutes',
  ),
  const Item(
    '45 minutes',
  ),
  const Item(
    '50 minutes',
  ),
  const Item(
    '55 minutes',
  ),
  const Item(
    '60 minutes',
  ),
];

var ingredients = <Widget>[];
var directions = <Widget>[];

Widget _customButton() {
  return Material(
    child: InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {},
      splashColor: Colors.blue,
      highlightColor: Colors.blue,
      child: Container(
        height: 36,
        width: 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text("Custom Button with InkWell"),
        ),
      ),
    ),
  );
}

class _CreateRecipeState extends State<CreateRecipe> {
  Item selectedUser1;
  Item selectedUser2;
  Item selectedUser3;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8.0,
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: Colors.red,
          icon: Icon(Icons.save),
          label: Text("Save"),
        ),
        appBar: AppBar(
          title: Text("Create Recipe"),
          backgroundColor: drawerBackgroundColor,
        ),
        body: Container(
          color: drawerBackgroundColor,
          child: Column(
            children: [
              Text("Recipe Name", style: style),
              TextFormField(
                style: style,
                expands: false,
                cursorColor: Colors.red,
              ),
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Prep Time",
                        style: style,
                      ),
                      DropdownButton<Item>(
                        style: style,
                        hint: Text("Minutes", style: style),
                        value: selectedUser1,
                        onChanged: (Item value) {
                          setState(() {
                            selectedUser1 = value;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  user.time,
                                  style: style,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("Meal Time", style: style),
                      DropdownButton<Item>(
                        style: style,
                        hint: Text("Minutes", style: style),
                        value: selectedUser2,
                        onChanged: (Item value) {
                          setState(() {
                            selectedUser2 = value;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  user.time,
                                  style: style,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Text("Total Time", style: style),
                      DropdownButton<Item>(
                        style: style,
                        hint: Text("Minutes", style: style),
                        value: selectedUser3,
                        onChanged: (Item value) {
                          setState(() {
                            selectedUser3 = value;
                          });
                        },
                        items: users.map((Item user) {
                          return DropdownMenuItem<Item>(
                            value: user,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  user.time,
                                  style: style,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  )
                ],
              ),
              Row(
                children: [
                  Text(
                    "Ingredients",
                    style: style,
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.red,
                    onPressed: () {
                      addNewIngredient();
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ingredients[index];
                },
              ),
              Row(
                children: [
                  Text(
                    "Direction",
                    style: style,
                  ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.red,
                    onPressed: () {
                      addNewDirection();
                    },
                    child: Icon(Icons.add),
                  ),
                ],
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: directions.length,
                itemBuilder: (context, index) {
                  return directions[index];
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void addNewIngredient() {
    setState(() {
      ingredients.add(TextFormField(style: style));
    });
  }

  void addNewDirection() {
    setState(() {
      directions.add(TextFormField(style: style));
    });
  }
}
