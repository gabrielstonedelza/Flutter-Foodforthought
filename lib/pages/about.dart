import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodforthought/gestures/mygestures.dart';
import 'package:foodforthought/pages/aboutustext.dart';
import 'package:foodforthought/pages/mydrawer.dart';

class AboutUs extends StatefulWidget{

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawer: MyDrawer(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text("Thought Today"),
            pinned: true,
            expandedHeight: 100.0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top:8.0,left: 10.0),
                child: Text("About Us",style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30,),
                Center(child: Text("Welcome to FoodForThought Group",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
                // SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: aboutUs(),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Connect with us on Facebook"),
                      SizedBox(height: 10,),
                      MyGestures("https://web.facebook.com/groups/142903436398","assets/images/facebook.svg")
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Center(
                    child: Text("Host",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)
                ),
                Column(
                  children: [
                    Text("Omannhene Yaw Adu-Boakye",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyGestures("https://web.facebook.com/omannhene.yawaduboakye", "assets/images/facebook.svg"),
                        SizedBox(width: 30,),
                        MyGestures("https://www.instagram.com/onanhene5/", 'assets/images/instagram.svg')
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Developer",style: TextStyle(fontWeight: FontWeight.bold),),
                    Text("Gabriel Akwasi Asare",style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: MyGestures("https://web.facebook.com/connect.django/","assets/images/facebook.svg"),
                        ),
                        // SizedBox(width: 30,),
                        Expanded(
                          child: MyGestures("https://www.instagram.com/gabriel_stonedelza/","assets/images/instagram.svg"),
                        ),
                        Expanded(
                          child: MyGestures("https://github.com/gabrielstonedelza","assets/images/github.svg"),
                        ),
                        Expanded(
                          child: MyGestures("https://medium.com/@gabrielstonedelza/about","assets/images/medium.svg"),
                        ),
                        Expanded(
                          child: MyGestures("https://www.linkedin.com/in/gabriel-akwasi-asare-2367021a6/","assets/images/linkedin.svg"),
                        ),

                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Email: gabrielstonedelza@gmail.com\n"),
                    Text("Phone: +233 593380008")
                  ],
                ),
                SizedBox(height: 100,)
              ])
          )
        ],
      ),
    );
  }
}