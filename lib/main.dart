import 'dart:math';

import 'package:cybersport/ui/browse.dart';
import 'package:cybersport/ui/home.dart';
import 'package:cybersport/ui/login.dart';
import 'package:cybersport/ui/home_page.dart';
import 'package:cybersport/ui/login_options.dart';
import 'package:cybersport/ui/manage_tour.dart';
import 'package:cybersport/ui/organizer_dashboard.dart';
import 'package:cybersport/ui/practice.dart';
import 'package:cybersport/ui/practice2.dart';
import 'package:cybersport/ui/preferences.dart';
import 'package:cybersport/ui/profile.dart';
import 'package:cybersport/ui/signup.dart';
import 'package:cybersport/ui/tour_details.dart';
import 'package:cybersport/ui/verify_email.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
    theme: ThemeData(primarySwatch: Colors.teal),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => new HomePage(),
      '/login': (BuildContext context) => new Login(),
      '/login_options': (BuildContext context) => new LoginOptions(),
      '/signup': (BuildContext context) => new SignUp(),
      '/browse': (BuildContext context) => new Browse(),
      '/preference': (BuildContext context) => new Pref(),
      '/profile': (BuildContext context) => new Profile(),
      '/organizer': (BuildContext context) => new OrgDash(),
      '/verify_email': (BuildContext context) => new VerifyEmail(),
      '/tour_details': (BuildContext context) => new TourDetails()
    },
    debugShowCheckedModeBanner: false,
    title: "CyberSport",
    home: Practices()));
