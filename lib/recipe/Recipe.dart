import 'dart:core';

class Recipe {
  var recipeName;
  var recipeDescription;
  List<dynamic> recipeIngredients;
  List<dynamic> recipeSteps;
  num recipePrepTime;
  num recipeCookTime;
  num recipeTotalTime;
  var imageFilepath;

  Recipe(this.recipeName, this.recipeDescription, this.recipeIngredients, this.recipeSteps,
      this.recipePrepTime, this.recipeCookTime, this.recipeTotalTime);

  String toString() {
    return "Name: $recipeName  Description: $recipeDescription  Prep time: $recipePrepTime  Cook time: $recipeCookTime";
  }
}
