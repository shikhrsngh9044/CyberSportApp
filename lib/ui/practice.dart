import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

class JsonApiDropdown extends StatefulWidget {
  @override
  JsonApiDropdownState createState() {
    return new JsonApiDropdownState();
  }
}

class JsonApiDropdownState extends State<JsonApiDropdown> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice'),
      ),
      body: Center(
        child: Container(
          child: Column(),
        ),
      ),
    );
  }
}
/* Container(
            margin: EdgeInsets.symmetric(horizontal: _minSpacing * 6),
            decoration: BoxDecoration(color: Colors.black12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getImageAsset(),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: _minSpacing * 2,
                            horizontal: _minSpacing * 2),
                        child: TextField(
                          controller: emailController,
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(fontSize: 15.0),
                            suffixIcon: Icon(Icons.alternate_email),
                            labelText: "Username",
                            hintText: "Email or Username",
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: _minSpacing * 2,
                            horizontal: _minSpacing * 2),
                        child: TextField(
                          controller: passController,
                          obscureText: true,
                          decoration: new InputDecoration(
                            errorStyle: TextStyle(fontSize: 15.0),
                            suffixIcon: Icon(Icons.lock_outline),
                            labelText: "Password",
                            hintText: "eg: \"abc123\"",
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: _minSpacing * 4,
                              horizontal: _minSpacing * 2),
                          child: Text("Forgot Password?"),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: _minSpacing * 4,
                              horizontal: _minSpacing * 2),
                          padding: EdgeInsets.all(_minSpacing * 2),
                          width: 150.0,
                          decoration: BoxDecoration(
                              color: Colors.redAccent,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Text(
                            "Login",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          margin: EdgeInsets.only(top: _minSpacing * 15),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ), */
