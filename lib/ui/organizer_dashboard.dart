import 'package:cybersport/ui/profile.dart';
import 'package:cybersport/ui/rank_prize_panel.dart';
import 'package:cybersport/ui/sub_org_panel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OrgDash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrgDashState();
  }
}

class _OrgDashState extends State<OrgDash> {
  var _formKey = GlobalKey<FormState>();
  var _minPadding = 5.0;
  int i = 0;
  bool loaded = false;

  int levels = 0;
  int pools = 0;

  List<Photo> photoList = new List();
  List<Photo> newPhotoList = new List();
  Photo _currentItem = new Photo(id: "0", title: "SELECT GAME", url: "abc");
  String _currentItemString = "SELECT GAME";

  List<int> teamsizes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _currentTeam = 0;
  String _currentTeamString = "TEAM SIZE";

  int _currentPool = 0;
  String _currentPoolString = "SELECT POOL";

  bool _matchConcurrency = false;
  String _matchConcurrencyString = "PARALLEL MATCHES";

  List<int> rankingType = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  int _currentRanking = 0;
  String _currentRankingString = "PRIZE STRUCTURE";

  List<String> temp = List();
  List<int> prizeList = List();
  bool isPrizeListAdded = false;
  int matches = 0;

  List<String> subOrgList = List();
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
            break;
          }
        }
      });
    }
  }

  /* Future<List<Photo>> getPhoList() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode != 200) {
      throw Exception("Error Ocurred");
    }
    photoList = (json.decode(response.body) as List)
        .map((data) => new Photo.fromJson(data))
        .toList();

    return photoList;
  } */

  /* void _buildList() async {
    List<Photo> tempList = await getPhoList();
    setState(() {
      for (Photo p in tempList) {
        if (i < 20) {
          newPhotoList.add(p);
          i++;
        } else {
          break;
        }
      }
    });
  } */

  TextEditingController titleController = TextEditingController();
  TextEditingController rulesController = TextEditingController();
  TextEditingController feeController = TextEditingController();

  @override
  void initState() {
    getPhoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create Tournament"),
          centerTitle: true,
          elevation: 4.0,
        ),
        body: !loaded
            ? const Center(
                child: const CircularProgressIndicator(),
              )
            : Form(
                key: _formKey,
                child: Container(
                  margin: EdgeInsets.all(_minPadding * 1.5),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Container(
                              margin: EdgeInsets.all(_minPadding * 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  //! This is games dropdown
                                  _gamesDropdown(),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, bottom: 5.0),
                                    child: TextFormField(
                                        controller: titleController,
                                        maxLength: 50,
                                        decoration: new InputDecoration(
                                            errorStyle:
                                                TextStyle(fontSize: 15.0),
                                            labelText: "Tournament Title",
                                            border: OutlineInputBorder())),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: TextFormField(
                                        textAlign: TextAlign.start,
                                        controller: rulesController,
                                        maxLines: 5,
                                        maxLength: 300,
                                        decoration: new InputDecoration(
                                            errorStyle:
                                                TextStyle(fontSize: 15.0),
                                            labelText: "Rules & Guidlines",
                                            border: OutlineInputBorder())),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 5.0,
                                              right: 5.0),
                                          child: TextFormField(
                                              controller: feeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: new InputDecoration(
                                                  errorStyle:
                                                      TextStyle(fontSize: 15.0),
                                                  hintText: "Fee per Player",
                                                  labelText: "Fee",
                                                  border:
                                                      OutlineInputBorder())),
                                        ),
                                      ),
                                      //!this is team dropdown
                                      _teamDropdown(),
                                    ],
                                  ),
                                  //!this is pool dropdown
                                  _poolDropdown(),
                                  _parallelDropDown(_currentPool),
                                  _subOrgPanel(_matchConcurrency),
                                  _rankingDropDown(),
                                  _rankingPanel(_currentRanking),
                                  _addCreateButton()
                                ],
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }

  Widget _addCreateButton() {
    return GestureDetector(
      onTap: () {
        debugPrint("Submit Clicked");
      },
      child: Container(
        margin: EdgeInsets.only(top: 10.0),
        height: 55.0,
        width: 100.0,
        decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          alignment: Alignment.center,
          child: Text("CREATE",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void _buttonSaveOnTap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    temp = prefs.getStringList("prizeList");

    for (var i = 0; i < temp.length; i++) {
      debugPrint("Item ${i + 1}: ${temp[i]}");
      prizeList.add(int.parse(temp[i]));
    }

    setState(() {
      isPrizeListAdded = true;
    });
  }

  void _poolChange(int pool) {
    setState(() {
      subOrgList.clear();
      subOrgList.add("");
      subOrgList.add("");
      subOrgList.add("");
      subOrgList.add("");
      subOrgList.add("");
      subOrgList.add("");
      subOrgList.add("");
      _currentPool = pool;

      switch (pool) {
        case 1:
          _currentPoolString = "POOL TYPE: 1 Pool";
          levels = 1;
          pools = 1;
          matches = 2;
          break;
        case 21:
          _currentPoolString = "POOL TYPE: 2 Pool";
          pools = 2;
          levels = 1;
          matches = 3;
          break;
        case 31:
          _currentPoolString = "POOL TYPE: 3 Pool";
          pools = 3;
          levels = 1;
          matches = 4;
          break;
        case 41:
          _currentPoolString = "POOL TYPE: 4 Pool";
          pools = 4;
          levels = 1;
          matches = 5;
          break;
        case 42:
          _currentPoolString = "POOL TYPE: 4 Pool, 2 Levels";
          pools = 4;
          levels = 2;
          matches = 7;
          break;
        default:
      }
    });
  }

  void _parallelChange(bool value) {
    setState(() {
      _matchConcurrency = value;

      switch (value) {
        case true:
          _matchConcurrencyString = "PARALLEL MATCHES: Yes";
          break;
        case false:
          _matchConcurrencyString = "PARALLEL MATCHES: No";
          break;
        default:
      }
    });
  }

  Widget _rankingPanel(int top) {
    if (top != 0 && !isPrizeListAdded) {
      return Container(
        margin: EdgeInsets.only(top: 20.0),
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
              child: Text(
                "Enter the prize distribution for each player",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            RankPrizePanel(
              winners: _currentRanking,
              onTapped: () {
                _buttonSaveOnTap();
              },
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _rankingDropDown() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
      height: 55.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white70),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            items: rankingType.map((rank) {
              return DropdownMenuItem<int>(
                child: Container(
                  child: Text(
                    "Top $rank",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: rank,
              );
            }).toList(),
            hint: Text(
              _currentRankingString,
            ),
            //value: _matchConcurrency,
            onChanged: (int value) {
              setState(() {
                temp.clear();
                prizeList.clear();

                isPrizeListAdded = false;
                _currentRanking = value;
                _currentRankingString = "PRIZE STRUCTURE: Top $value";
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _subOrgPanel(bool value) {
    if (value && _currentPool != 0) {
      return Container(
        margin: EdgeInsets.only(top: 20.0, bottom: 20.0),
        color: Colors.black12,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "Select Sub Organizer for Matches",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10.0, bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(left: 10.0, right: 10.0),
                      height: 150.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          fit: BoxFit.cover,
                          image: new NetworkImage(
                              "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                        ),
                      )),
                  Container(
                      height: 300.0,
                      margin: EdgeInsets.only(top: 10.0),
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            SubOrgPanel(
                              pool: pools,
                              level: levels,
                              onValueSelected: (value, index) {
                                if (subOrgList.isNotEmpty) {
                                  setState(() {
                                    /* subOrgList.insert(
                                        index, value.toString().substring(2)); */
                                    subOrgList[index] =
                                        value.toString().substring(2);
                                  });
                                }

                                //subOrgList.insert(index, value.toString().substring(2));
                                //debugPrint("$v : ${value.toString().substring(2)}");
                              },
                            ),
                          ])),
                  Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: GestureDetector(
                      onTap: () {
                        debugPrint("${Colors.amber.runtimeType}");
                        for (var i = 0; i < matches; i++) {
                          debugPrint("Item at $i : ${subOrgList[i]}");
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0),
                        height: 55.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(20.0)),
                        child: Container(
                          alignment: Alignment.center,
                          child: Text("SHOW",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _parallelDropDown(int poolType) {
    if (poolType != 0) {
      return Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
        height: 55.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white70),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<bool>(
              items: [
                DropdownMenuItem<bool>(
                  child: Container(
                    child: Text(
                      "Yes",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  value: true,
                ),
                DropdownMenuItem<bool>(
                  child: Container(
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  value: false,
                ),
              ],
              hint: Text(
                _matchConcurrencyString,
              ),
              //value: _matchConcurrency,
              onChanged: _parallelChange,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _poolDropdown() {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
      height: 55.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white70),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<int>(
            hint: Text(
              _currentPoolString,
            ),
            items: [
              DropdownMenuItem<int>(
                child: Container(
                  height: 30.0,
                  child: Text(
                    "1 Pool",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: 1,
              ),
              DropdownMenuItem<int>(
                child: Container(
                  height: 30.0,
                  child: Text(
                    "2 Pool",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: 21,
              ),
              DropdownMenuItem<int>(
                child: Container(
                  height: 30.0,
                  child: Text(
                    "3 Pool",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: 31,
              ),
              DropdownMenuItem<int>(
                child: Container(
                  height: 30.0,
                  child: Text(
                    "4 Pool",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: 41,
              ),
              DropdownMenuItem<int>(
                child: Container(
                  height: 30.0,
                  child: Text(
                    "4 Pool, 2 Levels",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),
                value: 42,
              )
            ],
            onChanged: _poolChange,
          ),
        ),
      ),
    );
  }

  Widget _teamDropdown() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(left: _minPadding, right: _minPadding),
        width: double.maxFinite,
        height: 55.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white70),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<int>(
              items: teamsizes
                  .map((value) => DropdownMenuItem<int>(
                        child: Container(
                          color: Colors.white30,
                          child: Text("$value"),
                        ),
                        value: value,
                      ))
                  .toList(),
              onChanged: (int input) {
                setState(() {
                  _currentTeam = input;
                  _currentTeamString = "TEAM SIZE: $input";
                });
              },
              isExpanded: false,
              hint: Text(
                _currentTeamString,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _gamesDropdown() {
    return Container(
      padding: EdgeInsets.only(left: _minPadding, right: _minPadding),
      width: double.maxFinite,
      height: 55.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54, width: 1.0),
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white70),
      //color: Colors.black12,
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton<Photo>(
            items: newPhotoList
                .map((photo) => DropdownMenuItem<Photo>(
                      child: Container(
                        color: Colors.white30,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                                margin:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
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
                            Text(photo.id),
                          ],
                        ),
                      ),
                      value: photo,
                    ))
                .toList(),
            onChanged: (Photo value) {
              setState(() {
                _currentItem = value;
                _currentItemString = "GAME: ${_currentItem.id}";
              });
            },
            isExpanded: false,
            hint: Center(
              child: Text(
                _currentItemString,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
