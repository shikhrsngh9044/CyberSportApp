import 'package:cybersport/blocs/home_bloc.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

/*class PhotosList {
  final List<Photo> photos;

  PhotosList({
    this.photos,
  });

  factory PhotosList.fromJson(Map<String, dynamic> pjson) {
    List<Photo> photos = new List<Photo>();
    photos = pjson.map((i) => Photo.fromJson(i)).toList();

    return PhotosList(photos: photos);
  }
}*/

class Photo {
  final String id;
  final String title;
  final String url;

  Photo({this.id, this.url, this.title});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return new Photo(
      id: json['id'].toString(),
      title: json['title'],
      url: json['url'],
    );
  }
}

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  List<Photo> list = new List();
  final _minPadding = 5.0;

  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();

  getPhoList() async {
    final response =
        await http.get("https://jsonplaceholder.typicode.com/photos");

    if (response.statusCode == 200) {
      setState(() {
        list = (json.decode(response.body) as List)
            .map((data) => new Photo.fromJson(data))
            .toList();
      });

      //debugPrint(list[1].title);
    }
  }

  @override
  void initState() {
    homeBloc.fetchAllPhotos();
    super.initState();
    // getPhoList();
  }

  @override
  void dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = "Name";
    contactController.text = "Contact";
    // TODO: implement build
    return Scaffold(
        body: Material(
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          Card(
            elevation: 2.0,
            color: Colors.white,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.all(_minPadding),
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")))),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.only(
                              left: _minPadding * 4,
                              right: _minPadding * 4,
                              top: _minPadding,
                              bottom: _minPadding),
                          child: Text("Username")),
                      Padding(
                          padding: EdgeInsets.only(
                              left: _minPadding * 4,
                              right: _minPadding * 4,
                              top: _minPadding,
                              bottom: _minPadding),
                          child: Text("Name")),
                      Padding(
                          padding: EdgeInsets.only(
                              left: _minPadding * 4,
                              right: _minPadding * 4,
                              top: _minPadding,
                              bottom: _minPadding),
                          child: Text("Email")),
                      Padding(
                          padding: EdgeInsets.only(
                              left: _minPadding * 4,
                              right: _minPadding * 4,
                              top: _minPadding,
                              bottom: _minPadding),
                          child: Text("Contact")),
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          StreamBuilder(
            stream: homeBloc.allPhotos,
            builder: (context, AsyncSnapshot<List<Photo>> snapshot) {
              if (snapshot.hasData) {
                return _getList(snapshot);
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    ));
  }

  Widget _getList(AsyncSnapshot<List<Photo>> snapshot) {
    return SizedBox(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.white70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.all(_minPadding),
                      width: 120.0,
                      height: 120.0,
                      decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new NetworkImage(
                                  snapshot.data[index].url.toString())))),
                  Container(
                      width: 200.0,
                      padding: EdgeInsets.only(
                          left: _minPadding * 4,
                          right: _minPadding * 4,
                          top: _minPadding,
                          bottom: _minPadding),
                      child: Text(snapshot.data[index].title))
                ],
              ));
        },
      ),
    );
  }
}
