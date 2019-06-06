import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final List<String> list;
  final int index;

  GameCard({this.list, this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
              height: 80.0,
              width: 80.0,
              decoration: new BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 2.0),
                image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                      "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                ),
              )),
          Expanded(
            child: Container(
                width: 80.0,
                margin: EdgeInsets.only(top: 10.0),
                child: Text(
                  list[index],
                  textAlign: TextAlign.center,
                )),
          )
        ],
      ),
    );
  }
}
