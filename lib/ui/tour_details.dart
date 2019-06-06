import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:expandable/expandable.dart';

class TourDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CollapsingList();
  }
}

class CollapsingList extends State<TourDetails> {
  bool isRegister = false;

  List<Photo> photoList = new List();
  final _minPadding = 5.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  getPhoList() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode == 200) {
      setState(() {
        photoList = (json.decode(response.body) as List)
            .map((data) => new Photo.fromJson(data))
            .toList();
      });
    }
  }

  //<=========TEMPORARY========>
  var _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  //<=========TEMPORARY========>

  SliverPersistentHeader makeHeader(String headerText) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 40.0,
        maxHeight: 60.0,
        child: Container(
            color: Colors.lightBlue,
            child: Center(
                child: Text(
              headerText,
              style: TextStyle(color: Colors.white, fontSize: 15.0),
            ))),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    getPhoList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        SliverAppBar(
            expandedHeight: 200.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "PUBG Tournament",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
              background: Container(
                  decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new NetworkImage(
                        "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.6), BlendMode.srcOver)),
              )),
            )),
        // ignore: missing_required_param
        makeHeader('Information'),
        SliverList(
          delegate: SliverChildListDelegate([
            Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 40.0, bottom: 40.0),
                child: Column(
                  children: <Widget>[
                    getImageAsset(),
                    Padding(
                        padding: EdgeInsets.all(_minPadding),
                        child: TextFormField(
                          controller: emailController,
                          validator: (String value) {
                            if (value.isEmpty)
                              return "Please enter email or username";
                            /*else if (EmailValidator.validate(value))
                            return "Please enter valid email";*/
                          },
                          decoration: new InputDecoration(
                              errorStyle: TextStyle(fontSize: 15.0),
                              prefixIcon: Icon(Icons.alternate_email),
                              labelText: "Email or Username",
                              // ignore: non_constant_identifier_names
                              border: OutlineInputBorder()),
                        )),
                    Padding(
                        padding: EdgeInsets.all(_minPadding),
                        child: TextFormField(
                          controller: passController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please enter password";
                            }
                          },
                          obscureText: true,
                          decoration: new InputDecoration(
                              errorStyle: TextStyle(fontSize: 15.0),
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: "Password",
                              border: OutlineInputBorder()),
                        )),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                            child: GestureDetector(
                          onTap: () {
                            //Navigator.of(context).pushReplacementNamed('/home');
                            setState(() {
                              /*if (_formKey.currentState.validate()) loggingInUser();*/
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(_minPadding),
                            alignment: Alignment.center,
                            height: 50.0,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(9.0)),
                            child: Text(
                              "Log In",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        )),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.all(_minPadding),
                            alignment: Alignment.center,
                            height: 50.0,
                            child: Text(
                              "Forgot Password?",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 15.0),
                            ),
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/signup');
                      },
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 50.0,
                        margin: EdgeInsets.only(top: 80.0),
                        child: Text(
                          "Create New Account",
                          style: TextStyle(color: Colors.blue, fontSize: 15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
        /*SliverFixedExtentList(
          itemExtent: 60.0,
          delegate: SliverChildListDelegate(
            [
              Center(child: Text("Information")),
            ],
          ),
        ),*/
        makeHeader('Registration'),
        SliverList(
          delegate:
              SliverChildBuilderDelegate((BuildContext context, int index) {
            return Card(
                elevation: 5.0,
                margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(2.0))),
                color: Colors.white70,
                clipBehavior: Clip.antiAlias,
                child: ExpandableNotifier(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                            height: 200.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new NetworkImage(
                                      "https://pixelz.cc/wp-content/uploads/2017/11/pubg-player-unknown-battlegrounds-cover-uhd-4k-wallpaper.jpg"),
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.4),
                                      BlendMode.srcOver)),
                            )),
                        Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(
                                left: _minPadding * 4,
                                right: _minPadding * 4,
                                bottom: _minPadding * 11),
                            child: Text(
                              photoList[index].title,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            )),
                      ]),
                      ExpandablePanel(
                        hasIcon: false,
                        tapHeaderToExpand: true,
                        header: Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: 10.0, left: 10.0, bottom: 5.0),
                              child: Text(
                                "SHOW MORE ",
                              )),
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
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 10.0),
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
          }),
        ),
        makeHeader('Participants'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
        makeHeader('Structure & Schedule'),
        SliverFixedExtentList(
          itemExtent: 150.0,
          delegate: SliverChildListDelegate(
            [
              Container(color: Colors.red),
              Container(color: Colors.purple),
              Container(color: Colors.green),
              Container(color: Colors.orange),
              Container(color: Colors.yellow),
            ],
          ),
        ),
      ],
    ));
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/cybersport.png');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.only(bottom: _minPadding * 15),
    );
  }

/*Widget createRegisterWidget() {
    if (isRegister) {
      return SliverFixedExtentList(
        itemExtent: 60.0,
        delegate: SliverChildListDelegate(
          [
            Center(child: Text("Registeration")),
            GestureDetector(
              onTap: () {
                //Navigator.of(context).pushReplacementNamed('/home');
                Fluttertoast.showToast(
                    msg: "Registration Clicked!",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0);
              },
              child: Container(
                margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                alignment: Alignment.center,
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.lightGreen, borderRadius: BorderRadius.zero),
                child: Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
              ),
            )
          ],
        ),
      );
    }

    return SliverFixedExtentList(
      itemExtent: 60.0,
      delegate: SliverChildListDelegate(
        [
          Center(child: Text("Registeration")),
          GestureDetector(
            onTap: () {
              //Navigator.of(context).pushReplacementNamed('/home');
              Fluttertoast.showToast(
                  msg: "Registration Clicked!",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIos: 1,
                  backgroundColor: Colors.black54,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
              alignment: Alignment.center,
              height: 50.0,
              decoration: BoxDecoration(
                  color: Colors.lightGreen, borderRadius: BorderRadius.zero),
              child: Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
            ),
          )
        ],
      ),
    );
  }*/
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
