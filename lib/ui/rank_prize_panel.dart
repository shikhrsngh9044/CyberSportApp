import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cybersport/globals.dart' as globals;

class RankPrizePanel extends StatefulWidget {
  final int winners;
  final Function() onTapped;

  RankPrizePanel({Key key, this.winners, this.onTapped}) : super(key: key);
  @override
  _RankPrizePanelState createState() => _RankPrizePanelState();
}

class _RankPrizePanelState extends State<RankPrizePanel> {
  List<dynamic> variableNames = List();
  List<TextEditingController> editingControllers = List();
  List<String> prizeList = List();

  bool _createVariables() {
    for (var i = 0; i < widget.winners; i++) {
      if (i <= (widget.winners - 1)) {
        variableNames.add("rankController$i");
      }
    }
    return true;
  }

  void _createEditingControllers(isVariableC) {
    for (var i = 0; i < widget.winners; i++) {
      editingControllers.add(variableNames[i] = TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    _createEditingControllers(_createVariables());
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: _getWinnersList(widget.winners),
    );
  }

  Widget _getWinnersList(int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _getListWinnerCards(widget.winners).toList(),
    );
  }

  List<Widget> _getListWinnerCards(int cardCount) {
    List<Widget> cardsList = List();
    for (var i = 0; i < cardCount; i++) {
      cardsList.add(_getWinnerCard(i, editingControllers[i]));
    }
    cardsList.add(_addSubmitButton());
    //cardsList.add(_addShowButton());

    return cardsList;
  }

  Widget _addSubmitButton() {
    return GestureDetector(
      onTap: () {
        _buttonOnTap();
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
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _buttonOnTap() {
    for (var i = 0; i < widget.winners; i++) {
      prizeList.add(editingControllers[i].text);
    }

    _prizePrefList();
  }

  void _prizePrefList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getKeys().contains("prizeList")) {
      prefs.getStringList("prizeList").clear();
    }
    prefs.setStringList("prizeList", prizeList);

    widget.onTapped();
  }

  Widget _getWinnerCard(int rank, TextEditingController editController) {
    return Container(
      height: 80.0,
      width: double.maxFinite,
      child: Card(
        color: Colors.white,
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 70.0,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: Text(
                "Rank ${rank + 1} :",
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            Container(
              width: 160.0,
              margin: EdgeInsets.only(left: 5.0, right: 5.0),
              child: TextFormField(
                controller: editController,
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty) return "Please enter prize";
                },
                decoration: new InputDecoration(
                    labelText: "Prize", border: OutlineInputBorder()),
              ),
            )
          ],
        ),
      ),
    );
  }
}
