import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiCallProvider {
  Future<List<Photo>> getPhoList() async {
    debugPrint("AppProviderClass : getPhotoList() called");
    List<Photo> photoList = List();
    List<Photo> newPhotoList = List();
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode == 200) {
      int i = 0;
      debugPrint("AppProviderClass : 200 Success");
      photoList = (json.decode(response.body) as List)
          .map((data) => Photo.fromJson(data))
          .toList();

      for (Photo p in photoList) {
        if (i < 40) {
          newPhotoList.add(p);
          i++;
        } else {
          break;
        }
      }

      return newPhotoList;
    } else {
      throw Exception("Some Error Occured");
    }
  }
}
