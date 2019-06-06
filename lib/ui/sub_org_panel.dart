import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubOrgPanel extends StatefulWidget {
  final int pool;
  final int level;
  final Function(dynamic value, dynamic value2) onValueSelected;
  final dynamic Function(dynamic value) onCardTapped;

  SubOrgPanel(
      {Key key, this.pool, this.level, this.onValueSelected, this.onCardTapped})
      : super(key: key);

  @override
  _SubOrgPanelState createState() => _SubOrgPanelState();
}

class _SubOrgPanelState extends State<SubOrgPanel> {
  //List<PopupMenuEntry<Object>> popupMenuEntries = List();

  List<String> usernames = List();

  //String username = "";

  @override
  Widget build(BuildContext context) {
    usernames.add("");
    usernames.add("");
    usernames.add("");
    usernames.add("");
    usernames.add("");
    usernames.add("");
    usernames.add("");
    return Container(
      child: Container(
        child: _getRows(widget.level, widget.pool),
      ),
    );
  }

  Widget _getRows(int level, int pool) {
    if (pool == 4 && level == 2) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(1, 1),
                _getMatchCard(1, 2),
                _getMatchCard(1, 3),
                _getMatchCard(1, 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(2, 5),
                _getMatchCard(2, 6),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(3, 7),
              ],
            ),
          ],
        ),
      );
    } else if (pool == 4 && level == 1) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(1, 1),
                _getMatchCard(1, 2),
                _getMatchCard(1, 3),
                _getMatchCard(1, 4),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(2, 5),
              ],
            ),
          ],
        ),
      );
    } else if (pool == 3 && level == 1) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(1, 1),
                _getMatchCard(1, 2),
                _getMatchCard(1, 3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(2, 4),
              ],
            ),
          ],
        ),
      );
    } else if (pool == 2 && level == 1) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(1, 1),
                _getMatchCard(1, 2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(2, 3),
              ],
            ),
          ],
        ),
      );
    } else if (pool == 1 && level == 1) {
      return Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _getMatchCard(1, 1),
              ],
            ),
          ],
        ),
      );
    }
  }

  Widget _getMatchCard(int levelNo, int matchNo) {
    String user = "";
    return Container(
      height: 100.0,
      width: 150.0,
      child: Card(
        color: Colors.blueAccent,
        elevation: 3.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 5,
              left: 5,
              child: Text(
                "$matchNo",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: Text(
                "Level: ${levelNo - 1}",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Positioned(
              top: 0.0,
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: PopupMenuButton<dynamic>(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        value: "$matchNo:First",
                        child: Center(child: Text("First")),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        value: "$matchNo:Second",
                        child: Center(child: Text("Second")),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        value: "$matchNo:Third",
                        child: Center(child: Text("Third")),
                      )
                    ],
                onSelected: (value) {
                  widget.onValueSelected(value, matchNo - 1);
                  setState(() {
                    //usernames.insert(matchNo - 1, value.toString());
                    usernames.insert(matchNo - 1, value.toString());
                    user = value.toString();
                  });
                },
                icon: Icon(
                  Icons.person_add,
                  size: 40.0,
                  color: Colors.white,
                ),
                offset: Offset(62.0, 50.0),
              ),
            ),
            Positioned(
              bottom: 5.0,
              left: 15.0,
              child: Text(
                usernames[matchNo - 1],
                style: TextStyle(color: Colors.amber),
              ),
            )
          ],
        ),
      ),
    );
  }

/*   Color _getColor(String status) {
    if (status == "Active") {
      return Colors.green;
    } else if (status == "Inactive") {
      return Colors.white;
    } else {
      return Colors.blueA;
    }
  } */
}
