import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';


class MyGestures extends StatelessWidget{
  String url;
  String assetPath;

  MyGestures(this.url,this.assetPath);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: mySvgImage(assetPath),
      onTap: () async{
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
    );
  }

  Widget mySvgImage(String assetPath){
    return Image(
      width: 40,
      height: 40,
      image: Svg(assetPath),
    );
  }
}