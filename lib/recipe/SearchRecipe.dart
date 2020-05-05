import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Home.dart';

class SearchRecipe extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<SearchRecipe> {
  TextEditingController editingController = TextEditingController();
  var duplicateItems = [
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
  var items = List<String>();

  @override
  void initState() {
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
        Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
        return true;
      },
      child: Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, MaterialPageRoute(builder: (context) => Home()));
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
                      onTap: () {},
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
