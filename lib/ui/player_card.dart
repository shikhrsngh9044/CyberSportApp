import 'package:cybersport/models/team.dart';
import 'package:flutter/material.dart';

class PlayerCard extends StatelessWidget {
  final Team team;
  final Function onValueSelected;

  PlayerCard({this.team, this.onValueSelected});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onValueSelected();
      },
      child: Card(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.all(Radius.circular(4.0))),
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 5.0,
                left: 5.0,
                child: Text(team.teamLeader),
              ),
              Positioned(top: 5.0, right: 5.0, child: Text("${team.teamsize}")),
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 60.0,
                  width: 60.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new NetworkImage(
                            "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                      )),
                ),
              ),
              Positioned(
                bottom: 5.0,
                left: 5.0,
                child: Text(team.name),
              )
            ],
          ),
        ),
      ),
    );
  }
}
