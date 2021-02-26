import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodforthought/pages/thoughttoday.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),()=> Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
      return ThoughtToday();
    }), (route) => false) );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xff363636),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/joyful-1.jpg'))),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text("Food For Thought ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23),),
                SizedBox(height: 10,),
                Text("with Omanhene",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                SizedBox(height: 15,),
                Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Color(0xff292929),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}