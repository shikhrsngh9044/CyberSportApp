import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:expandable/expandable.dart';

class TournamentCard extends StatelessWidget {
  final List<Photo> list;
  final int index;

  TournamentCard({this.list, this.index});

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(2.0))),
        color: Colors.white54,
        child: ExpandableNotifier(
          child: Column(
            children: <Widget>[
              Container(
                height: 200.0,
                child: Stack(children: <Widget>[
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
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: new BoxDecoration(
                          color: Color(0xA0B71C1C),
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 10.0)
                          ],
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(3.0),
                              bottomRight: Radius.circular(3.0))),
                      child: Text("Promoted",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
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
                          list[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.topRight,
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
                                border:
                                    Border.all(color: Colors.green, width: 2.0),
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
                                      color: Colors.white70, fontSize: 15.0)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              ExpandablePanel(
                hasIcon: false,
                tapHeaderToExpand: true,
                header: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin:
                          EdgeInsets.only(top: 20.0, right: 10.0, bottom: 5.0),
                      child: Text("MORE INFO",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600))),
                ),
                /* collapsed: Text(
                        "Details here....",
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                      ), */
                expanded: Text(
                  "This match will be played on  28 may 2019\nHello everyone how are you",
                  softWrap: true,
                  overflow: TextOverflow.fade,
                ),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding:
                        EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
