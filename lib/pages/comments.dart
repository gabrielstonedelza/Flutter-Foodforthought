import 'package:flutter/material.dart';
import 'package:foodforthought/pages/mydrawer.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'commentsandadd.dart';


class Comments extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommentsState();
  }
}

class _CommentsState extends State<Comments>{

  var userCommenting;
  bool isLoading = true;
  List comments = [];
  var commentItem;

  _fetchData() async{
    final url = "http://157.230.214.75/api/comments/";
    final response = await http.get(url);
    if(response.statusCode ==200){
      var myMembers = json.decode(response.body);
      comments = myMembers;
      comments.forEach((element) {
        userCommenting = element['name'];
      });
    }

    setState(() {
      isLoading = false;
      this.comments = comments;
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
        title: Text("Comments"),
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
          itemCount: this.comments != null ? this.comments.length : 0,
          itemBuilder: (context,i){
            commentItem = comments[i];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shadowColor: Colors.white,
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ListTile(
                    leading: Icon(Icons.person_outline_outlined),
                    title: Text(commentItem['name']),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            commentItem['comment']
                        ),
                        SizedBox(height: 10,),
                        Text(commentItem['date_of_comment'])
                      ],
                    ),
                    // trailing: Text(commentItem['date_of_comment']),
                  ),
                ),
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Color(0xff303030),
        backgroundColor: Color(0xff030303),
        child: Icon(Icons.add_comment,color: Colors.white,),
        elevation: 10.0,
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return CommentsAddPage();
          }));
        },
      ),
    );
  }
}