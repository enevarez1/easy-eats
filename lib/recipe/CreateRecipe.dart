import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../HomePage.dart';
import 'Recipe.dart';

TextStyle style = TextStyle(color: Colors.black);

String recipeName;
String recipeDescription;
var ingredientNumber = 0;
var directionNumber = 0;
var ingredients = <Widget>[];
var directions = <Widget>[];
var ingredientsList = <String>[];
var directionsList = <String>[];
var imageFilepath;
int selectedUser1;
int selectedUser2;
var timeList = new List<int>.generate(12, (i) => (i + 1) * 5);

class CreateRecipe extends StatefulWidget {
  _CreateRecipeState createState() => _CreateRecipeState();
}

class _CreateRecipeState extends State<CreateRecipe> {
  /// Controllers for TextFields.
  final TextEditingController _ingredientsEditingController = TextEditingController();
  final TextEditingController _directionEditingController = TextEditingController();
  final TextEditingController _recipeNameEditingController = TextEditingController();
  final TextEditingController _recipeDescriptionEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        //back button press.
        _clearWidgetData();
        Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
        return true; //allows the user to go back if true
      },
      child: Material(
        elevation: 8.0,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              //Save button pressed
              Recipe current = _saveRecipe();
              _clearWidgetData();
              Navigator.pop(context, current);
            },
            icon: Icon(Icons.save),
            label: Text("Save"),
          ),
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _clearWidgetData();
                Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
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
                    keyboardType: TextInputType.multiline,
                    controller: _recipeNameEditingController,
                    validator: (String inValue) {
                      if (inValue.length == 0) {
                        return "Please enter the Ingredients!";
                      }
                      return null;
                    },
                  ),
                  Text("Recipe Description", style: style),
                  TextFormField(
                    maxLines: null,
                    maxLengthEnforced: false,
                    keyboardType: TextInputType.multiline,
                    controller: _recipeDescriptionEditingController,
                    validator: (String inValue) {
                      if (inValue.length == 0) {
                        return "Please enter the Ingredients!";
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      createTimeWidget("Prep Time", false),
                      createTimeWidget("Cook Time", true)
                    ],
                  ),
                  createWidgetList("Ingredients", false),
                  createWidgetList("Directions", true),
                  imageFilepath == null
                      ? SizedBox()
                      : Image.file(
                          File(imageFilepath),
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
    Widget bottomListTile(IconData iconData) {
      return ListTile(
          onTap: () {
            if (iconData == Icons.photo_camera) {
              _showPhotoCamera();
            } else {
              _showPhotoLibrary();
            }
          },
          leading: Icon(iconData),
          title: Text("Take a picture from camera"));
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 120,
              child: Column(children: <Widget>[
                bottomListTile(Icons.photo_camera),
                bottomListTile(Icons.photo_library)
              ]));
        });
  }

  Widget createWidgetList(String typeName, bool type) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              typeName,
              style: style,
            ),
            RaisedButton(
              shape: StadiumBorder(),
              color: Colors.blue,
              onPressed: () {
                if (type) {
                  addNewIngredient(ingredientNumber + 1);
                } else {
                  addNewDirection(directionNumber + 1);
                }
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            RaisedButton(
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              shape: StadiumBorder(),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  if (type) {
                    ingredientNumber = 0;
                    ingredients.removeLast();
                    ingredientsList.removeLast();
                  } else {
                    directionNumber = 0;
                    directions.removeLast();
                    directionsList.removeLast();
                  }
                });
              },
            ),
          ],
        ),
        type
            ? ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  return ingredients[index];
                },
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: directions.length,
                itemBuilder: (context, index) {
                  return directions[index];
                },
              ),
        TextFormField(
          maxLines: null,
          decoration: InputDecoration(hintText: "$typeName For Recipe"),
          keyboardType: TextInputType.multiline,
          controller: type ? _ingredientsEditingController : _directionEditingController,
          validator: (String inValue) {
            if (inValue.length == 0) {
              return "Please enter the $typeName!";
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget createTimeWidget(String s, bool type) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButton<int>(
          style: style,
          hint: Text("Minutes", style: style),
          value: type ? selectedUser1 : selectedUser2,
          onChanged: (int value) {
            setState(() {
              if (type) {
                selectedUser1 = value;
              } else {
                selectedUser2 = value;
              }
            });
          },
          items: timeList.map((int time) {
            return DropdownMenuItem<int>(
              value: time,
              child: Row(
                children: <Widget>[
                  Text(
                    time.toString(),
                    style: style,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        Text(
          s,
          style: style,
        ),
      ],
    );
  }

  void _showPhotoLibrary() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFilepath = file.path;
    });
  }

  void _showPhotoCamera() async {
    final file = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFilepath = file.path;
    });
  }

  void addNewIngredient(int i) {
    setState(() {
      ingredientNumber = i;
      ingredientsList.add(_ingredientsEditingController.text);
      ingredients.add(Text("$i. ${_ingredientsEditingController.text}", style: style));
      _ingredientsEditingController.text = "";
    });
  }

  void addNewDirection(int i) {
    setState(() {
      directionNumber = i;
      directionsList.add(_directionEditingController.text);
      directions.add(Text("$i. ${_directionEditingController.text}", style: style));
      _directionEditingController.text = "";
    });
  }

  Recipe _saveRecipe() {
    Recipe currentRecipe = Recipe();
    currentRecipe.recipeName = _recipeNameEditingController.text;
    currentRecipe.recipeDescription = _recipeDescriptionEditingController.text;
    currentRecipe.recipeIngredients = ingredientsList;
    currentRecipe.recipeSteps = directionsList;
    currentRecipe.recipePrepTime = selectedUser1;
    currentRecipe.recipeCookTime = selectedUser2;
    currentRecipe.imageFilepath = imageFilepath;
    return currentRecipe;
  }

  ///Cleans the page so when coming back into this page, nothing is populated
  void _clearWidgetData() {
    imageFilepath = null;
    ingredientNumber = 0;
    directionNumber = 0;
    ingredients = <Widget>[];
    directions = <Widget>[];
  }
}
