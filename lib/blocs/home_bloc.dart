import 'package:cybersport/ui/profile.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:cybersport/resources/repository.dart';

class HomeBloc {
  final _repository = Repository();
  final _photoFetcher = PublishSubject<List<Photo>>();

  Observable<List<Photo>> get allPhotos => _photoFetcher.stream;

  fetchAllPhotos() async {
    debugPrint("HomeBlocClass : fetchAllPhotos() called");
    List<Photo> photoList = await _repository.getPhotoList();
    _photoFetcher.sink.add(photoList);
  }

  void dispose() {
    _photoFetcher.close();
  }
}

final homeBloc = HomeBloc();
