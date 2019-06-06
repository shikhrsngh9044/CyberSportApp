import 'package:cybersport/ui/login.dart';
import 'package:flutter/material.dart';

class LoginOptions extends StatelessWidget {
  final _minPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          getImageAsset(),
        ],
      )),
    );
  }

/* getImageAsset(),
                Container(
                    margin: EdgeInsets.only(top: _minPadding * 10),
                    //padding: EdgeInsets.all(0.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: _minPadding, right: _minPadding),
                        alignment: Alignment.center,
                        height: 60.0,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Text(
                          "Log In with Email",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
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
                        /*Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));*/
                      },
                      child: Container(
                        margin: EdgeInsets.all(_minPadding),
                        alignment: Alignment.center,
                        height: 50.0,
                        decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(9.0)),
                        child: Text(
                          "Google",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                      ),
                    )),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()))*/
                        },
                        child: Container(
                          margin: EdgeInsets.all(_minPadding),
                          alignment: Alignment.center,
                          height: 50.0,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(9.0)),
                          child: Text(
                            "Facebook",
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/signup');
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
                ) */

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
}
