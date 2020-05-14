import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../HomePage.dart';
import 'RecipeModel.dart';

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

class ViewRecipe extends StatefulWidget {
  Recipe currentRecipe;

  ViewRecipe({this.currentRecipe});

  _ViewRecipeState createState() => _ViewRecipeState(currentRecipe: currentRecipe);
}

class _ViewRecipeState extends State<ViewRecipe> {
  Recipe currentRecipe;

  _ViewRecipeState({this.currentRecipe});

  @override
  Widget build(BuildContext context) {
    imageFilepath = currentRecipe.imageFilepath;
    ingredientsList = currentRecipe.recipeIngredients;
    directionsList = currentRecipe.recipeSteps;
    setNewIngredient();
    setNewDirections();
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
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                _clearWidgetData();
                Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            title: Text("View Recipe"),
            backgroundColor: Colors.blue,
          ),
          body: Container(
              color: Colors.white,
              child: ListView(
                children: [
                  Text("Recipe Name", style: style),
                  TextFormField(
                    readOnly: true,
                    initialValue: currentRecipe.recipeName,
                    maxLines: 1,
                    keyboardType: TextInputType.multiline,
                    validator: (String inValue) {
                      if (inValue.length == 0) {
                        return "Please enter the Ingredients!";
                      }
                      return null;
                    },
                  ),
                  Text("Recipe Description", style: style),
                  TextFormField(
                    readOnly: true,
                    initialValue: currentRecipe.recipeDescription,
                    maxLines: null,
                    maxLengthEnforced: false,
                    keyboardType: TextInputType.multiline,
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
                          DropdownButton<int>(
                            style: style,
                            hint: Text(currentRecipe.recipePrepTime.toString(), style: style),
                            value: null,
                            onChanged: (int value) {},
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
                            "Prep Time",
                            style: style,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DropdownButton<int>(
                            style: style,
                            hint: Text(currentRecipe.recipeCookTime.toString(), style: style),
                            value: null,
                            onChanged: (int value) {},
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
                            "Cook Time",
                            style: style,
                          ),
                        ],
                      )
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
                ],
              )),
        ),
      ),
    );
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
      ],
    );
  }

  void setNewIngredient() {
    setState(() {
      int i = 0;
      ingredientsList.forEach((element) {
        i++;
        ingredients.add(Text("$i. $element", style: style));
      });
    });
  }

  void setNewDirections() {
    setState(() {
      int i = 0;
      directionsList.forEach((element) {
        i++;
        directions.add(Text("$i. $element", style: style));
      });
    });
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
