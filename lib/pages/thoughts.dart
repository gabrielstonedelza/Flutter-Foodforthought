import 'package:flutter/material.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:foodforthought/pages/thought_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'mydrawer.dart';

class Thoughts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThoughtState();
  }
}

class _ThoughtState extends State<Thoughts>{

  bool isLoading = true;
  var title = "";
  List items = [];
  var thoughts;

  _fetchData() async{
    final url = "http://157.230.214.75/api/thoughtlist/";
    final response = await http.get(url);

    if(response.statusCode == 200){
      var myJsonData = json.decode(response.body);
      items = myJsonData;
    }

    setState(() {
      isLoading = false;
      this.items = items;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
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
        title: Text("Thoughts"),
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
          itemCount: this.items != null ? this.items.length :0,
          itemBuilder: (context,i){
            thoughts = items[i];
            return Container(
              // height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shadowColor: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)
                  ),
                  child: ListTile(
                    title: Text(thoughts['title'],style: TextStyle(fontSize: 16),),
                    subtitle: Row(
                      children: [
                        Expanded(child: Text(thoughts['date_posted'].toString().split("T").first)),
                      ],
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return ThoughtDetail(this.items[i]['title'], this.items[i]['id']);

                      }));
                    },
                  ),
                ),
              ),
            );
          }
      )
    );
  }
}