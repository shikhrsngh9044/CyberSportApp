import 'package:cybersport/resources/api_call_provider.dart';
import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';

class Repository {
  final apiCallProvider = ApiCallProvider();

  Future<List<Photo>> getPhotoList() {
    debugPrint("RepositoryClass : getPhotoList() called");
    return apiCallProvider.getPhoList();
  }
}
