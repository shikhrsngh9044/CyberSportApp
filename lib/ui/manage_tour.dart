import 'dart:io';
import 'dart:math';

import 'package:cybersport/app_screen_widgets/image_picker.dart';
import 'package:cybersport/ui/manage_match_panel.dart';
import 'package:cybersport/ui/player_card.dart';
import 'package:cybersport/ui/team_bottom_sheet.dart';
import 'package:cybersport/ui/winner_bottom_sheet.dart';
import 'package:cybersport/ui/winner_card.dart';
import 'package:cybersport/models/team.dart';
import 'package:cybersport/models/winner.dart';
import 'package:cybersport/app_screen_widgets/sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class ManageTour extends StatefulWidget {
  @override
  _ManageTourState createState() => _ManageTourState();
}

class _ManageTourState extends State<ManageTour> {
  bool isResultUploaded = false;
  int teamSize = 2;
  File _image;

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: SliverAppBarDelegate(
        minHeight: 35.0,
        maxHeight: 45.0,
        child: Container(
            color: Colors.amber,
            child: Center(
                child: Text(
              headerText,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverAppBar(
          floating: true,
          pinned: true,
          title: Text(
            "Tournament Title",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blueAccent,
          elevation: 1.0,
        ),
        SliverToBoxAdapter(
          child: MatchManagePanel(
            onValueSelected: () {},
          ),
        ),
        makeHeader("Winners & Result"),
        _getResultImage(),
        _getWinnerPanel(),
        _publishButton(),
        makeHeader("Players"),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Container(
                child: PlayerCard(
              team: teams[index],
              onValueSelected: () {
                _openTeamBottomSheet(context);
              },
            ));
          }, childCount: teams.length),
        )
      ],
    ));
  }

  Widget _getWinnerPanel() {
    if (isResultUploaded) {
      return SliverFixedExtentList(
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return Container(
            child: WinnerCard(
              winner: winners[index],
              onValueSelected: () {
                _openWinnerBottomSheet(context);
              },
            ),
          );
        }, childCount: winners.length),
        itemExtent: 90.0,
      );
    } else {
      return SliverToBoxAdapter();
    }
  }

  Widget _getResultImage() {
    if (!isResultUploaded) {
      return ImagePick(
        onSelected: (File image, bool status) {
          setState(() {
            _image = image;
            isResultUploaded = true;
          });
        },
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(
          margin: EdgeInsets.all(5.0),
          height: 200.0,
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(10.0)),
          child: Image.file(_image),
        ),
      );
    }
  }

  Widget _publishButton() {
    if (isResultUploaded) {
      return SliverToBoxAdapter(
          child: Container(
        margin:
            EdgeInsets.only(top: 20.0, left: 100.0, right: 100.0, bottom: 20.0),
        height: 50.0,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 5.0),
                  blurRadius: 5.0)
            ]),
        child: Center(
          child: Text("Publish",
              style: TextStyle(color: Colors.white, fontSize: 15.0)),
        ),
      ));
    } else {
      return SliverToBoxAdapter();
    }
  }

  Color _getColor(int rank) {
    if (rank == 1) {
      return Colors.amberAccent;
    } else if (rank == 2) {
      return Colors.grey;
    } else if (rank == 3) {
      return Colors.redAccent;
    }
  }

  void _openWinnerBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return WinnerBottomSheet(
            items: winners,
          );
        });
  }

  void _openTeamBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext buildContext) {
          return TeamBottomSheet();
        });
  }
}
