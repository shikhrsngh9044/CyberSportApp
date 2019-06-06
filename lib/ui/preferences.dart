import 'package:flutter/material.dart';

class Pref extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: Column(
          children: <Widget>[],
        ),
      ),
    );
  }
}

//prize pool,match count,team size,date_time of match

/* 
Stack(children: <Widget>[
                  Container(
                      decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                        colorFilter: ColorFilter.mode(
                            Colors.black54.withOpacity(0.2),
                            BlendMode.srcOver)),
                  )),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        height: 50.0,
                        alignment: Alignment.center,
                        decoration: new BoxDecoration(
                            shape: BoxShape.rectangle,
                            backgroundBlendMode: BlendMode.srcOver,
                            color: Colors.black.withOpacity(0.4)),
                        child: Text(
                          photoList[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 10.0, right: 5.0, top: 5.0, bottom: 5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              height: 35.0,
                              width: 35.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new NetworkImage(
                                      "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                                ),
                              )),
                          Expanded(
                            child: Container(
                              child: Text("Shikhar",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 14.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ])

 */
