import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'myloading.dart';

class CommentsAddPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommentsAddPageState();
  }
}

class _CommentsAddPageState extends State<CommentsAddPage>{
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _commentController = TextEditingController();

  bool showEmoji = false;
  bool isLoading = true;
  FocusNode focusNode = FocusNode();
  List comments = [];
  var commentItems;

  _fetchComment() async{
    final commentUrl = "http://157.230.214.75/api/comments/";
    final commentResponse = await http.get(commentUrl);
    if(commentResponse.statusCode == 200){
      var postComments = json.decode(commentResponse.body);
      comments = postComments;
      comments.forEach((element) {
        print(element['name']);
        print(element['comment']);
      });
    }
    setState(() {
      isLoading = false;
      this.comments = comments;
    });
  }

  _addToComment() async{
    await http.post("http://157.230.214.75/api/comments/",
        body: {"name": _nameController.text,"comment": _commentController.text,},
        headers: {"Content-Type": "application/x-www-form-urlencoded"}
    );
    Navigator.of(context).pushNamedAndRemoveUntil('/comments', ModalRoute.withName('/commentsadd'));
  }


  @override
  void initState() {
    _fetchComment();
    super.initState();
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          showEmoji = false;
        });
      }
    });
    setState(() {
      _fetchComment();
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

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
                child: Text("Add your comment",style: TextStyle(fontSize: 20.0),),
              ),
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            // ListView.builder(
            //     itemCount: this.comments != null ? this.comments : 0,
            //     itemBuilder: (context,i){
            //       commentItems = comments[i];
            //       return Card(
            //         child: ListTile(
            //           title: Text(commentItems['name']),
            //           subtitle: Text(commentItems['comment']),
            //         ),
            //       );
            //     }
            // ),
            SizedBox(height: 30,),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(height: 30,),
                    Text("Was this thought helpful?"),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "enter name",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)
                        )
                      ),
                      // ignore: missing_return
                      validator: (value){
                        if(value.isEmpty){
                          // ignore: missing_return, missing_return
                          return "name can't be empty";
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _commentController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "enter comment",
                          prefixIcon: Icon(Icons.comment),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)
                          )
                      ),
                      // ignore: missing_return
                      validator: (value){
                        if(value.isEmpty){
                          // ignore: missing_return, missing_return
                          return "comment can't be empty";
                        }
                      },
                    ),
                    SizedBox(height: 30,),
                    Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                            child: Text("Save"),
                            onPressed: (){
                              if(!_formKey.currentState.validate()){
                                return;
                              }else{
                                _addToComment();
                              }
                            },
                            color: Color(0xFF292929),
                            splashColor: Color(0xFF3d3d3d),
                            textColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                        ),
                        SizedBox(width: 30,),
                        Expanded(
                          child: RaisedButton(
                            child: Text("Cancel"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                            color: Color(0xFF292929),
                            splashColor: Color(0xFF3d3d3d),
                            textColor: Colors.white,
                            shape: StadiumBorder(),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ]))
        ],
      )
    );
  }
}