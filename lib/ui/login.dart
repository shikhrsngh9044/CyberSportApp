import 'package:cybersport/models/login_response.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:cybersport/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<LoginResponse> loginUser(String email, String pass) async {
  return http.post("${globals.baseUrl}/user/login",
      body: {'email': email, 'password': pass}).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode != 200) {
      throw Exception('$statusCode');
    }
    return LoginResponse.fromJson(json.decode(response.body));
  });
}

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  var _formKey = GlobalKey<FormState>();
  String email = "";
  String pass = "";
  final _minPadding = 5.0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  _LoginState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getImageAsset(),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
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
                                suffixIcon: Icon(Icons.alternate_email),
                                labelText: "Email or Username",
                                // ignore: non_constant_identifier_names
                                border: OutlineInputBorder()),
                          )),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: _minPadding * 2,
                              horizontal: _minPadding),
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
                                suffixIcon: Icon(Icons.lock_outline),
                                labelText: "Password",
                                border: OutlineInputBorder()),
                          )),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
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

  void loggingInUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = emailController.text;
    String pass = passController.text;

    LoginResponse loginResponse = await loginUser(email, pass);
    if (loginResponse.message == "success" && loginResponse.token.isNotEmpty) {
      Fluttertoast.showToast(
          msg: "Logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);

      prefs.setString("token", "Bearer ${loginResponse.token}");
      prefs.setString("userId", "${loginResponse.data.id}");
      Navigator.of(context).pushReplacementNamed("/home");
    }
    /*debugPrint(loginResponse.message);
    debugPrint(loginResponse.token);*/

    /* FutureBuilder<LoginResponse>(
      future: loginResponse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.token);
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        // By default, show a loading spinner
        return CircularProgressIndicator();
      },
    );*/
  }
}

/*
RaisedButton(
child: Text(
"LogIn",
style: TextStyle(
color: Colors.white, fontSize: 20.0),
),
color: Colors.blue,
shape: new RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10.0)),
elevation: _minPadding,
onPressed: () {})*/

/*
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius.circular(9.0)),
child: Text(
"Log In",
style: TextStyle(color: Colors.white, fontSize: 18.0),
)*/

/* ListView(
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
                            if (_formKey.currentState.validate())
                              loggingInUser();
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
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
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
              ), */
