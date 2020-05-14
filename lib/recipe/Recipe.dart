import "package:flutter/material.dart";
import "package:scoped_model/scoped_model.dart";

import '../HomePage.dart';
import '../RecipeDBWorker.dart';
import 'RecipeModel.dart';

/// The Document screen.
class Recipes extends StatelessWidget {
  /// Constructor.
  Recipes() {
    print("-- Document.constructor");
    recipeModel.loadData("documents", RecipeDBWorker.db);
  }

  Widget build(BuildContext inContext) {
    print("-- Documents.build()");

    return ScopedModel<RecipeModel>(
        model: recipeModel,
        child: ScopedModelDescendant<RecipeModel>(
            builder: (BuildContext inContext, Widget inChild, RecipeModel inModel) {
          return IndexedStack(index: 0, children: [HomePage()]);
        }));
  }
}
