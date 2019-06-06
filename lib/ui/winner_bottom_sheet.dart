import 'package:cybersport/models/winner.dart';
import 'package:flutter/material.dart';

class WinnerBottomSheet extends StatefulWidget {
  final List<Winner> items;
  WinnerBottomSheet({Key key, this.items}) : super(key: key);
  @override
  _WinnerBottomSheetState createState() => _WinnerBottomSheetState();
}

class _WinnerBottomSheetState extends State<WinnerBottomSheet> {
  List<Winner> items = List();

  @override
  void initState() {
    items.addAll(widget.items);
    super.initState();
  }

  @override
  TextEditingController _editingController = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 25.0,
            color: Colors.greenAccent,
            child: Center(
              child: Text("Search and select the winner",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _editingController,
              onChanged: (value) {
                filterSearchList(value);
              },
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search team leader",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0))),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${items[index].name}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void filterSearchList(String query) {
    List<Winner> dummySearchList = List();

    dummySearchList.addAll(items);

    if (query.isNotEmpty) {
      List<Winner> dummyListData = List();

      dummySearchList.forEach((item) {
        if (item.name.contains(query)) {
          dummyListData.add(item);
        } else {}
      });

      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(widget.items);
      });
    }
  }
}
