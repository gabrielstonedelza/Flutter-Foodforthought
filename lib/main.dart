import 'package:flutter/material.dart';
import 'package:foodforthought/constants.dart';
import 'package:foodforthought/pages/about.dart';
import 'package:foodforthought/pages/comments.dart';
import 'package:foodforthought/pages/commentsandadd.dart';
import 'package:foodforthought/pages/members.dart';
import 'package:foodforthought/pages/newmember.dart';
import 'package:foodforthought/pages/thoughttoday.dart';
import 'package:foodforthought/pages/thoughts.dart';
import 'package:foodforthought/pages/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kBackgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/today': (BuildContext context) => ThoughtToday(),
        '/thoughts': (BuildContext context) => Thoughts(),
        '/members': (BuildContext context) => Members(),
        '/becomeMember': (BuildContext context) => NewMemberPage(),
        '/aboutus': (BuildContext context) => AboutUs(),
        '/comments': (BuildContext context) => Comments(),
        '/commentsadd': (BuildContext context) => CommentsAddPage()
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WelcomeScreen();
  }
}


