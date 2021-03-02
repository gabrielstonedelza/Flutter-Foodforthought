import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewMemberPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NewMemberPageState();
  }
}

class _NewMemberPageState extends State<NewMemberPage> with AutomaticKeepAliveClientMixin{


  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  var name;

  List allMembers = [];
  bool _isMember = false;

  _chechMember() async{
    final url = "http://157.230.214.75/api/members/";
    final response = await http.get(url);
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);

    }
  }

  _becomeMember() async{
    await http.post("http://157.230.214.75/api/members/",
        body: {"name": _nameController.text,"email":_emailController.text},
        headers: {"Content-Type": "application/x-www-form-urlencoded"}
    );
    showAlertDialog(_nameController.text);
    Navigator.of(context).pushNamedAndRemoveUntil('/members', ModalRoute.withName('/becomeMember'));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _chechMember();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                child: Text("Become a member",style: TextStyle(fontSize: 20.0),),
              ),
            ),

          ),
          SliverList(
              delegate: SliverChildListDelegate([
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30,),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.person),
                              labelText: "Enter name",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)
                              )
                          ),
                          // ignore: missing_return
                          validator: (value){
                            if(value.isEmpty){
                              return "name cannot be empty";
                            }
                          },
                          onSaved: (value){
                            name = value;
                          },

                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email_rounded),
                              labelText: "Enter email",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0)
                              )
                          ),
                          keyboardType: TextInputType.emailAddress,
                          // ignore: missing_return
                          validator: (value){
                            if(value.isEmpty){
                              return "email cannot be empty";
                            }
                            if(!RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(value)){
                              return "Please enter a valid email";
                            }
                            return null;
                          },

                        ),

                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Expanded(
                              child: RaisedButton(
                                child: Text("Save"),
                                onPressed: (){
                                  if(!_formKey.currentState.validate()){
                                    return;
                                  }else{
                                    _becomeMember();
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
              ])
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void showAlertDialog(String name){
    AlertDialog alertDialog = AlertDialog(
      title: Text("Success"),
      content: Text("$name,you just become a member of foodforthought"),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
}