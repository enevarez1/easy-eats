import 'dart:io';

import 'package:easy_eats/recipe/Recipe.dart';
import "package:path/path.dart";
import "package:sqflite/sqflite.dart";

/// Database provider class for recipes.

Directory docsDir;

class RecipeDBWorker {
  /// Static instance and private constructor, since this is a singleton.
  RecipeDBWorker._();

  static final RecipeDBWorker db = RecipeDBWorker._();

  /// The one and only database instance.
  Database _db;

  /// Get singleton instance, create if not available yet.
  ///
  /// @return The one and only Database instance.
  Future get database async {
    if (_db == null) {
      _db = await init();
    }
    return _db;
  }

  /// Initialize database.
  ///
  /// @return A Database instance.
  /// TODO add recipeIngredients and recipeSteps
  Future<Database> init() async {
    String path = join(docsDir.path, "recipes.db");
    Database db = await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database inDB, int inVersion) async {
      await inDB.execute("CREATE TABLE IF NOT EXISTS recipes ("
          "id INTEGER PRIMARY KEY,"
          "recipeName TEXT,"
          "recipeDescription TEXT,"
          "recipePrepTime INTEGER,"
          "recipeCookTime INTEGER,"
          "recipeTotalTime INTEGER,"
          "imageFilepath TEXT,"
          ")");
    });
    return db;
  }

  /// Create a recipes from a Map.
  /// TODO add missing values to save
  Recipe recipeFromMap(Map inMap) {
    Recipe recipe = Recipe();
    recipe.id = inMap["id"];
    return recipe;
  }

  /// Create a Map from a recipes.
  /// TODO add missing map values
  Map<String, dynamic> recipeToMap(Recipe recipe) {
    Map<String, dynamic> map = Map<String, dynamic>();
    map["id"] = recipe.id;
    return map;
  }

  /// Create a recipe.
  ///
  /// @param  recipe The recipe object to create.
  /// @return        Future.
  /// TODO add missing values to return await db.rawInsert()
  Future create(Recipe recipe) async {
    Database db = await database;
    // Get largest current id in the table, plus one, to be the new ID.
    var val = await db.rawQuery("SELECT MAX(id) + 1 AS id FROM recipes");
    int id = val.first["id"];
    if (id == null) {
      id = 1;
    }

    // Insert into table.
    return await db.rawInsert("INSERT INTO recipes (id) VALUES (?)", [id]);
  }

  /// Get a specific recipe.
  ///
  /// @param  inID The ID of the recipe to get.
  /// @return      The corresponding recipe object.
  Future<Recipe> get(int inID) async {
    Database db = await database;
    var rec = await db.query("recipes", where: "id = ?", whereArgs: [inID]);
    return recipeFromMap(rec.first);
  }

  /// Get all recipes.
  ///
  /// @return A List of recipe objects.
  Future<List> getAll() async {
    Database db = await database;
    var recs = await db.query("recipes");
    var list = recs.isNotEmpty ? recs.map((m) => recipeFromMap(m)).toList() : [];
    return list;
  }

  /// Update a recipe.
  ///
  /// @param recipe The recipe to update.
  /// @return       Future.
  Future update(Recipe recipe) async {
    Database db = await database;
    return await db.update("recipes", recipeToMap(recipe), where: "id = ?", whereArgs: [recipe.id]);
  }

  /// Delete a recipe.
  ///
  /// @param inID The ID of the recipe to delete.
  /// @return     Future.
  Future delete(int inID) async {
    Database db = await database;
    return await db.delete("recipes", where: "id = ?", whereArgs: [inID]);
  }
}
