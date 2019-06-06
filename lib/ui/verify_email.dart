import 'package:cybersport/models/register.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:cybersport/globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<Register> registerUser({Map body}) async {
  return http
      .post("${globals.baseUrl}/user/register", body: body)
      .then((http.Response response) {
    if (response.statusCode != 201) {
      return Register.fromJson(new Register(message: "error").toMap());
    }
    return Register.fromJson(json.decode(response.body));
  });
}

class VerifyEmail extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VerifyEmailState();
  }
}

class _VerifyEmailState extends State<VerifyEmail> {
  var _formKey = GlobalKey<FormState>();
  final _minPadding = 5.0;

  TextEditingController otpController = TextEditingController();

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
                      top: 40.0, bottom: 100.0, left: 5.0, right: 5.0),
                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        getLogoImageAsset(),
                        Padding(
                            padding: EdgeInsets.only(
                                left: _minPadding * 4,
                                right: _minPadding * 4,
                                top: _minPadding ,
                                bottom: _minPadding),
                            child: TextFormField(
                              controller: otpController,
                              keyboardType: TextInputType.text,
                              validator: (String value) {
                                if (value.isEmpty)
                                  return "OTP field must not be empty";
                              },
                              decoration: new InputDecoration(
                                  errorStyle: TextStyle(fontSize: 15.0),
                                  prefixIcon: Icon(Icons.phonelink_lock),
                                  labelText: "OTP",
                                  // ignore: non_constant_identifier_names
                                  border: OutlineInputBorder()),
                            )),
                        SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            //Navigator.of(context).pushReplacementNamed('/home');
                            setState(() {
                              if (_formKey.currentState.validate()) verifyEmail();
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
                              "Verify",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ),
    );
  }

  void verifyEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String name = prefs.getString("name").toString();
    String email = prefs.getString("email").toString();
    String contact = prefs.getString("contact").toString();
    String username = prefs.getString("username").toString();
    String password = prefs.getString("password").toString();

    Register newUser = new Register(
        name: name,
        email: email,
        contact: contact,
        username: username,
        password: password);

    //Register response = await registerUser(body: newUser.toMap());

    if (otpController.text == prefs.getString("otp")) {
      Register response = await registerUser(body: newUser.toMap());

      if (response.message == "success") {
        Fluttertoast.showToast(
            msg: "User Registered and Verified",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0);

        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        Fluttertoast.showToast(
            msg: "Some error occurred",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Wrong Otp Entered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
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
      margin: EdgeInsets.only(bottom: _minPadding * 25),
    );
  }
}

/*void signingUpUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  OtpResponse response = await preRegisterUser(
      emailController.text.toString(), uNameController.text.toString());

  if (response.otp != null) {
    Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);

    prefs.setString("name", nameController.text);
    prefs.setString("email", emailController.text);
    prefs.setString("username", uNameController.text);
    prefs.setString("contact", contactController.text);
    prefs.setString("password", passController.text);
    prefs.setString("otp", response.otp);

    Navigator.of(context).pushReplacementNamed("/verify_email");
  } else {
    Fluttertoast.showToast(
        msg: response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black12,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}*/

/*Future<OtpResponse> preRegisterUser(String email, String username) async {
  return http.post("${globals.baseUrl}/user/pre-register", body: {
    'email': email,
    'username': username
  }).then((http.Response response) {
    if (response.statusCode == 409) {
      return OtpResponse.fromJson(json.decode(response.body));
    }
    return OtpResponse.fromJson(json.decode(response.body));
  });
}*/
