import 'package:cybersport/app_screen_widgets/game_card_widget.dart';
import 'package:cybersport/app_screen_widgets/tournament_card.dart';
import 'package:cybersport/blocs/home_bloc.dart';
import 'package:cybersport/ui/profile.dart';
import 'package:cybersport/app_screen_widgets/sliver_persistent_header_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  List<String> gamesList = new List();

  final _minPadding = 5.0;

  @override
  void initState() {
    super.initState();

    gamesList.add("PUBG");
    gamesList.add("PUBG-M");
    gamesList.add("CS:GO");
    gamesList.add("TOM CLANCY:GHOST");
    gamesList.add("FAR CRY");
    gamesList.add("CLASH ROYALE");

    homeBloc.fetchAllPhotos();
  }

  @override
  void dispose() {
    super.dispose();
    homeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverAppBar(
          floating: false,
          pinned: true,
          backgroundColor: Colors.lightBlue,
          title: Text("CyberSport"),
        ),
        SliverToBoxAdapter(
          child: Container(
            height: 150.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: gamesList.length,
              itemBuilder: (context, index) {
                return GameCard(
                  list: gamesList,
                  index: index,
                );
              },
            ),
          ),
        ),
        makeHeader("Sponsored & Promoted"),
        StreamBuilder(
          stream: homeBloc.allPhotos,
          builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return TournamentCard(
                    list: snapshot.data,
                    index: index,
                  );
                }, childCount: snapshot.data.length),
              );
            } else if (snapshot.hasError)
              SliverToBoxAdapter(child: Text(snapshot.error.toString()));
            else
              return SliverToBoxAdapter(
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Center(child: CircularProgressIndicator())));
          },
        ),
        makeHeader("Latest"),
        StreamBuilder(
          stream: homeBloc.allPhotos,
          builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return TournamentCard(
                    list: snapshot.data,
                    index: index,
                  );
                }, childCount: snapshot.data.length),
              );
            } else if (snapshot.hasError)
              SliverToBoxAdapter(child: Text(snapshot.error.toString()));
            else
              return SliverToBoxAdapter(
                  child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: Center(child: CircularProgressIndicator())));
          },
        )
      ],
    ));
  }
}
