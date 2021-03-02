import 'package:flutter/material.dart';
import 'package:foodforthought/pages/about.dart';
import 'package:foodforthought/pages/comments.dart';
import 'package:foodforthought/pages/members.dart';
import 'package:foodforthought/pages/thoughttoday.dart';
import 'package:foodforthought/pages/thoughts.dart';

class MyDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("FoodForThought",style: TextStyle(fontWeight: FontWeight.bold),),
            accountEmail: Text("dailymotivational@gmail.com",style: TextStyle(fontWeight: FontWeight.bold),),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/images/bible.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Today",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Thought for today"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return ThoughtToday();
              }));
            },
          ),

          ListTile(
            leading: Icon(Icons.lightbulb_outline_rounded),
            title: Text("Thoughts",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("All thoughts"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Thoughts();
                }));
              }
          ),
          ListTile(
            leading: Icon(Icons.people_outline_outlined),
            title: Text("Members",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("Our Members"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Members();
                }));
              }
          ),
          ListTile(
              leading: Icon(Icons.comment),
              title: Text("Comments",style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("Feedbacks"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return Comments();
                }));
              }
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("About",style: TextStyle(fontWeight: FontWeight.bold),),
            subtitle: Text("About us"),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return AboutUs();
                }));
              }
          ),

        ],
      ),
    );
  }
}