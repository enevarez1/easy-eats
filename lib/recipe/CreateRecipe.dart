import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Home.dart';

class CreateRecipe extends StatefulWidget {
  _CreateRecipeState createState() => _CreateRecipeState();
}

TextStyle style = TextStyle(color: Colors.black);

class Item {
  const Item(this.time);

  final String time;
}

List<Item> timeCounter = <Item>[
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
var ingredientNumber = 0;
var directionNumber = 0;
var ingredients = <Widget>[];
var directions = <Widget>[];
var ingredientList = <String>[];
var directionList = <String>[];
var filepath;

class _CreateRecipeState extends State<CreateRecipe> {
  Item selectedUser1;
  Item selectedUser2;
  Item selectedUser3;

  /// Controllers for TextFields.
  final TextEditingController _ingredientsEditingController = TextEditingController();
  final TextEditingController _directionEditingController = TextEditingController();
  final TextEditingController _recipeNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _ingredientsEditingController.addListener(() {});
    _directionEditingController.addListener(() {});
    return new WillPopScope(
      onWillPop: () async {
        filepath = null;
        ingredientNumber = 0;
        directionNumber = 0;
        ingredients = <Widget>[];
        directions = <Widget>[];
        return true;
      },
      child: Material(
        elevation: 8.0,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              filepath = null;
              ingredientNumber = 0;
              directionNumber = 0;
              ingredients = <Widget>[];
              directions = <Widget>[];
              //TODO save created recipe here
              Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(Icons.save),
            label: Text("Save"),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                filepath = null;
                ingredientNumber = 0;
                directionNumber = 0;
                ingredients = <Widget>[];
                directions = <Widget>[];
                Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
              },
            ),
            title: Text("Create Recipe"),
            backgroundColor: Colors.blue,
          ),
          body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Text("Recipe Name", style: style),
                  TextFormField(
                    maxLines: 1,
                    decoration: InputDecoration(hintText: "Ingredients For Recipe"),
                    keyboardType: TextInputType.multiline,
                    controller: _recipeNameEditingController,
                    validator: (String inValue) {
                      if (inValue.length == 0) {
                        return "Please enter the Ingredients!";
                      }
                      return null;
                    },
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
                            items: timeCounter.map((Item user) {
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
                            items: timeCounter.map((Item user) {
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
                            items: timeCounter.map((Item user) {
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
                  Column(
                    children: [
                      Text(
                        "Ingredients",
                        style: style,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: ingredients.length,
                        itemBuilder: (context, index) {
                          return ingredients[index];
                        },
                      ),
                      TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(hintText: "Ingredients For Recipe"),
                        keyboardType: TextInputType.multiline,
                        controller: _ingredientsEditingController,
                        validator: (String inValue) {
                          if (inValue.length == 0) {
                            return "Please enter the Ingredients!";
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {
                          addNewIngredient(ingredientNumber + 1);
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Direction",
                        style: style,
                      ),
                      ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: directions.length,
                        itemBuilder: (context, index) {
                          return directions[index];
                        },
                      ),
                      TextFormField(
                        maxLines: 2,
                        decoration: InputDecoration(hintText: "Direction For Recipe"),
                        keyboardType: TextInputType.multiline,
                        controller: _directionEditingController,
                        validator: (String inValue) {
                          if (inValue.length == 0) {
                            return "Please enter the directions!";
                          }
                          return null;
                        },
                      ),
                      RaisedButton(
                        shape: StadiumBorder(),
                        color: Colors.blue,
                        onPressed: () {
                          addNewDirection(directionNumber + 1);
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                  filepath == null
                      ? SizedBox()
                      : Image.file(
                          File(filepath),
                          height: 500,
                          width: 500,
                        ),
                  RaisedButton(
                    shape: StadiumBorder(),
                    color: Colors.blue,
                    onPressed: () {
                      _showOptions(context);
                    },
                    child: Icon(Icons.camera),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      _showPhotoCamera();
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary();
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      filepath = file.path;
    });
  }

  void _showPhotoCamera() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      filepath = file.path;
    });
  }

  void addNewIngredient(int i) {
    setState(() {
      ingredientNumber = i;
      ingredientList.add(_ingredientsEditingController.text);
      ingredients.add(Text("$i. ${_ingredientsEditingController.text}", style: style));
      _ingredientsEditingController.text = "";
    });
  }

  void addNewDirection(int i) {
    setState(() {
      directionNumber = i;
      directionList.add(_directionEditingController.text);
      directions.add(Text("$i. ${_directionEditingController.text}", style: style));
      _ingredientsEditingController.text = "";
    });
  }
}
