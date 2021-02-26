import 'package:flutter/material.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'newmember.dart';


class Members extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MembersState();
  }
}

class _MembersState extends State<Members>{

  var memberName;
  bool isLoading = true;
  List members = [];
  var items;

  _fetchData() async{
    final url = "http://157.230.214.75/api/members/";
    final response = await http.get(url);
    if(response.statusCode ==200){
      var myMembers = json.decode(response.body);
      members = myMembers;
      members.forEach((element) {
        memberName = element['name'];
      });
    }

    setState(() {
      isLoading = false;
      this.members = members;
    });
  }

  @override
  void initState(){
    setState(() {
      _fetchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {
                isLoading = true;
              });
              _fetchData();
            },
          )
        ],
      ),
      drawer: MyDrawer(),
      body: isLoading ? MyLoading() : ListView.builder(
          itemCount: this.members != null ? this.members.length : 0,
          itemBuilder: (context,i){
            items = members[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListTile(
                    leading: Icon(Icons.person,color: Color(0xff030303)),
                    title: Text(items['name']),
                  ),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Color(0xff303030),
        backgroundColor: Color(0xff030303),
        child: Icon(Icons.add,color: Colors.white,),
        elevation: 10.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return NewMemberPage();
          }));
        },
      ),
    );
  }
}