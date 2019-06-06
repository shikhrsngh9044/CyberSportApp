import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ImagePick extends StatefulWidget {
  final Function(File, bool) onSelected;

  ImagePick({Key key, this.onSelected}) : super(key: key);

  @override
  _ImagePickState createState() => _ImagePickState();
}

class _ImagePickState extends State<ImagePick> {
  //File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    /* setState(() {
      _image = image;
    }); */

    if (image != null) {
      widget.onSelected(image, true);
    } else {
      Fluttertoast.showToast(
          msg: "Image Not Selected!!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                iconSize: 30.0,
                icon: Icon(Icons.add_circle),
                onPressed: getImage,
              ),
              Text(
                "Choose and upload result image!",
              )
            ],
          ),
        ),
      ),
    );
  }
}
