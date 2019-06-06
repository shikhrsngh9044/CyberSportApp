import 'package:cybersport/models/winner.dart';
import 'package:flutter/material.dart';

class WinnerCard extends StatelessWidget {
  final Winner winner;
  final Function onValueSelected;

  WinnerCard({this.winner, this.onValueSelected});
  @override
  Widget build(BuildContext context) {
    final winnerCard = Container(
      margin: EdgeInsets.only(left: 30.0),
      height: 90.0,
      decoration: BoxDecoration(
          color: Colors.black12,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0))
          ]),
      child: Container(
        margin: EdgeInsets.only(left: 45.0, top: 5.0, bottom: 5.0, right: 5.0),
        constraints: BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              winner.name,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            Text(
              winner.username,
              style: TextStyle(fontSize: 13.0, color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                "${winner.rank}",
                style: TextStyle(fontSize: 20.0, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );

    return GestureDetector(
      onTap: () {
        onValueSelected();
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Stack(
          children: <Widget>[
            winnerCard,
            Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: imageThumbnail)
          ],
        ),
      ),
    );
  }

  final imageThumbnail = Container(
    alignment: FractionalOffset.centerLeft,
    height: 60.0,
    width: 60.0,
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: new DecorationImage(
          fit: BoxFit.cover,
          image: new NetworkImage(
              "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
        )),
  );
}
