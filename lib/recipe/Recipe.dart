import 'dart:core';

class Recipe {
  int id;
  String recipeName = "Name";
  String recipeDescription = "Description";
  List<dynamic> recipeIngredients;
  List<dynamic> recipeSteps;
  int recipePrepTime = 20;
  int recipeCookTime = 25;
  int recipeTotalTime = 55;
  var imageFilepath = "";
  
  String toString() {
    return "Name: $recipeName  Description: $recipeDescription  Prep time: $recipePrepTime  Cook time: $recipeCookTime";
  }
}
