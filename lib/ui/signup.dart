import 'dart:async';
import 'package:cybersport/models/otp_response.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cybersport/globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<OtpResponse> preRegisterUser(String email, String username) async {
  return http.post("${globals.baseUrl}/user/pre-register", body: {
    'email': email,
    'user_name': username
  }).then((http.Response response) {
    if (response.statusCode == 409) {
      return OtpResponse.fromJson(json.decode(response.body));
    }
    return OtpResponse.fromJson(json.decode(response.body));
  });
}

class SignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignUpState();
  }
}

class _SignUpState extends State<SignUp> {
  var _formKey = GlobalKey<FormState>();

  DateTime dob = DateTime(2003);

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController uNameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime(2003),
        firstDate: DateTime(1979),
        lastDate: DateTime(2003));
    if (selectedDate != null && selectedDate != dob)
      setState(() {
        dob = selectedDate;
      });
  }

  final _minPadding = 5.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Material(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 40.0, bottom: 40.0, left: 5.0, right: 5.0),
            child: Center(
              child: ListView(
                children: <Widget>[
                  getLogoImageAsset(),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.text,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Name field must not be empty";
                        },
                        decoration: new InputDecoration(
                            errorStyle: TextStyle(fontSize: 15.0),
                            prefixIcon: Icon(Icons.person),
                            labelText: "Full Name",
                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Please enter email or username";
                          /*else if (EmailValidator.validate(value))
                            return "Please enter valid email";*/
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            labelText: "Email",
                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: uNameController,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Please enter unique username";
                        },
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.person_pin),
                            labelText: "Username",
                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: contactController,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Please enter primary contact number";
                          else if (value.length != 10)
                            return "Please enter valid contact number";
                        },
                        keyboardType: TextInputType.phone,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone_android),
                            labelText: "Contact",
                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: passController,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Plaese enter your password";
                          else if (value != confPassController.text)
                            return "Password not match";
                        },
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            labelText: "Password",
                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  Padding(
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: TextFormField(
                        controller: confPassController,
                        validator: (String value) {
                          if (value.isEmpty)
                            return "Plaese confirm your password";
                          else if (value != passController.text)
                            return "Password not match";
                        },
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "Confirm Password",

                            // ignore: non_constant_identifier_names
                            border: OutlineInputBorder()),
                      )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              left: _minPadding * 4,
                              right: _minPadding,
                              top: _minPadding,
                              bottom: _minPadding),
                          height: 55.0,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(color: Colors.black54)),
                          child: Text(
                            "DOB : ${dob.day}/${dob.month}/${dob.year}",
                            style: TextStyle(
                                color: Colors.black54, fontSize: 18.0),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(
                                  left: _minPadding * 2,
                                  right: _minPadding * 4,
                                  top: _minPadding,
                                  bottom: _minPadding),
                              child: getCalendarImageAsset())),
                    ],
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.of(context).pushReplacementNamed('/home');
                      setState(() {
                        if (_formKey.currentState.validate()) signingUpUser();
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding * 4,
                          bottom: _minPadding * 2),
                      alignment: Alignment.center,
                      height: 50.0,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(9.0)),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signingUpUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    OtpResponse response = await preRegisterUser(
        emailController.text.toString(), uNameController.text.toString());

    if (response.otp != null) {
      Fluttertoast.showToast(
          msg: response.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);

      prefs.setString("name", nameController.text);
      prefs.setString("email", emailController.text);
      prefs.setString("username", uNameController.text);
      prefs.setString("contact", contactController.text);
      prefs.setString("password", passController.text);
      prefs.setString("otp", response.otp);

      Navigator.of(context).pushNamed("/verify_email");
    } else {
      Fluttertoast.showToast(
          msg: response.message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Widget getCalendarImageAsset() {
    AssetImage assetImage = AssetImage('images/calendar.png');
    Image image = Image(
      image: assetImage,
      width: 45.0,
      height: 45.0,
    );

    return Container(
      child: image,
    );
  }

  Widget getLogoImageAsset() {
    AssetImage assetImage = AssetImage('images/cybersport.png');
    Image image = Image(
      image: assetImage,
      width: 150.0,
      height: 150.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.only(bottom: _minPadding * 5),
    );
  }
}
