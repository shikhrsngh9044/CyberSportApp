import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Practices extends StatelessWidget {
  final double _minSpacing = 5.0;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
          child: clipRectangle,
        ),
      ),
    );
  }

  var clipRectangle = ClipRect(
    clipBehavior: Clip.antiAlias,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      color: Colors.tealAccent,
      height: 500.0,
      width: 200.0,
    ),
    clipper: RectangleClipper(),
  );
  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/cybersport.png');
    Image image = Image(
      image: assetImage,
      width: 120.0,
      height: 120.0,
    );

    return Container(
      child: image,
      margin: EdgeInsets.symmetric(vertical: _minSpacing * 4),
    );
  }
}

class RectangleClipper extends CustomClipper<ClipRRect> {
  @override
  getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, size.height - 200.0);
    //

    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
   
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => false;
}
