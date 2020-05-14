import 'dart:core';

import 'package:easy_eats/model/BaseModel.dart';

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
}

/// The model backing this entity type's views.
class RecipeModel extends BaseModel {
  int id;
  String recipeName;
  String recipeDescription;
  List<dynamic> recipeIngredients;
  List<dynamic> recipeSteps;
  int recipePrepTime;
  int recipeCookTime;
  int recipeTotalTime;
  var imageFilepath;
}

RecipeModel recipeModel = RecipeModel();
