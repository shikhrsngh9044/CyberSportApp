import 'package:flutter/material.dart';

class Browse extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Material(
        child: Center(
          child: Text(
            "Browse Tab",
            style: TextStyle(fontSize: 30.0),
          ),
        ),
      ),
    );
  }
}
