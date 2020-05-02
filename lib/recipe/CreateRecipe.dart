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
              TextFormField(),
              TextFormField(),
              Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Prep Time"),
                      DropdownButton<Item>(
                        style: TextStyle(color: Colors.white),
                        hint: Text("Minutes"),
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
                                  style: TextStyle(color: Colors.black),
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
                      Text("Meal Time"),
                      DropdownButton<Item>(
                        style: TextStyle(color: Colors.white),
                        hint: Text("Minutes"),
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
                                  style: TextStyle(color: Colors.black),
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
                      Text("Total Time"),
                      DropdownButton<Item>(
                        style: TextStyle(color: Colors.white),
                        hint: Text("Minutes"),
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
                                  style: TextStyle(color: Colors.black),
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
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  addNewIngredient();
                },
                child: Text(
                  "Add Ingredient",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ingredients[index];
                },
              ),
              RaisedButton(
                color: Colors.red,
                onPressed: () {
                  addNewDirection();
                },
                child: Text(
                  "Add Direction",
                  style: TextStyle(color: Colors.white),
                ),
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
      ingredients.add(TextFormField());
    });
  }

  void addNewDirection() {
    setState(() {
      directions.add(TextFormField());
    });
  }
}
