import 'dart:core';

class Recipe {
  int id;
  String recipeName;
  String recipeDescription;
  List<dynamic> recipeIngredients;
  List<dynamic> recipeSteps;
  int recipePrepTime;
  int recipeCookTime;
  int recipeTotalTime;
  var imageFilepath;

  Recipe();

  String toString() {
    return "Name: $recipeName  Description: $recipeDescription  Prep time: $recipePrepTime  Cook time: $recipeCookTime";
  }
}
