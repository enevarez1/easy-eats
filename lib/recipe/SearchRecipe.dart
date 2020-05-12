import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../HomePage.dart';
import 'ViewRecipe.dart';

class SearchRecipe extends StatefulWidget {
  var recipes;

  SearchRecipe({this.recipes});

  @override
  _SearchState createState() => _SearchState(recipes: recipes);
}

class _SearchState extends State<SearchRecipe> {
  TextEditingController editingController = TextEditingController();
  var duplicateItems = <String>[];
  var items = List<String>();
  var recipes;

  _SearchState({this.recipes});

  @override
  void initState() {
    recipes.forEach((element) {
      duplicateItems.add(element.recipeName);
    });
    items.addAll(duplicateItems);
    super.initState();
  }

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
        return true;
      },
      child: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          title: new Text("Search"),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewRecipe(currentRecipe: recipes[index])));
                      },
                      title: Text('${items[index]}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
