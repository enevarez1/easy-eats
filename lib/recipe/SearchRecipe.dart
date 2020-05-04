

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchRecipe extends StatefulWidget {

  var _searchEdit = new TextEditingController();
  bool _isSearch = true;
  String _searchText = "";
  List<String> _searchListItems;
  List<String> _recipeListItems;




  @override
  _SearchState createState() {
    return new _SearchState();
  }
  
}

class _SearchState extends State<SearchRecipe> {

  var _searchEdit = new TextEditingController();
  bool _isSearch = true;
  String _searchText = "";
  List<String> _searchListItems;
  List<String> _recipeListItems;

  
  void initState() { 
    super.initState();
    _recipeListItems = new List<String>();
    _recipeListItems = [
      "Chicken",
      "Burrito",
      "Ice Cream",
      "Poptart",
      "Strudel",
      "Bacon",
      "Cheon",
      "Elsa",
      "Ben",
      "Apple",
      "Leslie",
      "Strawberries",
      "Cherries",
      "Salad",
      "Pizza",
      "Meatloaf"
    ];
    _recipeListItems.sort();
  }

  _SearchState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Search List"),
      ),
      body: new Container(
        margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: new Column(
          children: <Widget>[
            _searchBox(),
            _isSearch ? _listView() : _searchListView()
          ],
        ),
      ),
    );
  }

  
  Widget _searchBox() {
    return new Container(
      decoration: BoxDecoration(border: Border.all(width: 1.0)),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: new TextStyle(color: Colors.grey[300]),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _recipeListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.cyan[50],
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_recipeListItems[index]}"),
              ),
            );
          }),
    );
  }

  Widget _searchListView() {
    _searchListItems = new List<String>();
    for (int i = 0; i < _recipeListItems.length; i++) {
      var item = _recipeListItems[i];

      if (item.toLowerCase().contains(_searchText.toLowerCase())) {
        _recipeListItems.add(item);
      }
    }
    return _searchAddList();
  }

  Widget _searchAddList() {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
              color: Colors.cyan[100],
              elevation: 5.0,
              child: new Container(
                margin: EdgeInsets.all(15.0),
                child: new Text("${_searchListItems[index]}"),
              ),
            );
          }),
    );
  }

}