import "package:scoped_model/scoped_model.dart";

class BaseModel extends Model {
  /// The list of entities.
  List entityList = [];

  /// The entity being edited.
  var entityBeingEdited;

  /// Load data from database.
  ///
  /// @param inEntityType The type of entity being loaded ("appointments", "contacts", "notes" or "tasks").
  /// @param inDatabase   The DBProvider.db instance for the entity.
  void loadData(String inEntityType, dynamic inDatabase) async {
    print("-- ${inEntityType}Model.loadData()");

    // Load entities from database.
    entityList = await inDatabase.getAll();
    notifyListeners();
  }
}
