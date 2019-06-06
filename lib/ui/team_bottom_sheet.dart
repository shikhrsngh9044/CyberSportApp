import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TeamBottomSheet extends StatefulWidget {
  @override
  _TeamBottomSheetState createState() => _TeamBottomSheetState();
}

class _TeamBottomSheetState extends State<TeamBottomSheet> {
  @override
  Widget build(BuildContext context) {
    final teamLabel = Container(
      height: 25.0,
      color: Colors.redAccent,
      child: Center(
        child: Text(
          "Team Name",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );

    final teamContent = Container(
      margin: EdgeInsets.only(top: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(top: 10.0),
            child: Text(
              "Team Players :",
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: 250.0,
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container();
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );

    return Container(
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: <Widget>[teamContent, teamLabel],
      ),
    );
  }
}
