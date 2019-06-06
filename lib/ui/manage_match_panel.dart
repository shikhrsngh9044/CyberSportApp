import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MatchManagePanel extends StatefulWidget {
  final Function onValueSelected;
  MatchManagePanel({Key key, this.onValueSelected}) : super(key: key);
  @override
  _MatchManagePanelState createState() => _MatchManagePanelState();
}

class _MatchManagePanelState extends State<MatchManagePanel> {
  List<Photo> photoList = new List();
  List<Photo> newPhotoList = new List();
  List<bool> isItemClicked = new List();
  bool loaded = false;
  bool selected = false;
  int selectedValue = 1;
  Color selectedColor = Colors.red;

  getPhoList() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode == 200) {
      int i = 0;
      setState(() {
        photoList = (json.decode(response.body) as List)
            .map((data) => new Photo.fromJson(data))
            .toList();
        loaded = true;
        for (Photo p in photoList) {
          if (i < 20) {
            newPhotoList.add(p);
            i++;
          } else {
            for (var i = 0; i < newPhotoList.length; i++) {
              if (i == 0) {
                isItemClicked.add(true);
              } else {
                isItemClicked.add(false);
              }
            }
            break;
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getPhoList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _setSelectedValue(index);
              },
              child: Container(
                height: 80.0,
                width: 120.0,
                child: Card(
                  color: _getColor(false),
                  elevation: 3.0,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Pool : ${index + 1}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 10.0,
                          width: double.maxFinite,
                          child: Container(
                            decoration: BoxDecoration(
                                color: isItemClicked[index]
                                    ? selectedColor
                                    : Colors.transparent,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4.0),
                                    bottomRight: Radius.circular(4.0))),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: newPhotoList.length),
    );
  }

  Color _getColor(bool status) {
    if (status) {
      return Colors.green;
    } else {
      return Colors.teal;
    }
  }

  void _setSelectedValue(int index) {
    for (var i = 0; i < newPhotoList.length; i++) {
      if (isItemClicked[i] = true) {
        setState(() {
          isItemClicked[i] = false;
        });
      }
    }

    setState(() {
      isItemClicked[index] = true;
    });
  }
}
