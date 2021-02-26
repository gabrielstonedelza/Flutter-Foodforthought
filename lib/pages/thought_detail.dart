import 'package:flutter/material.dart';
import 'package:foodforthought/pages/myloading.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'mydrawer.dart';

class ThoughtDetail extends StatefulWidget{
  String detailTitle;
  int detailId;
  ThoughtDetail(this.detailTitle,this.detailId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ThoughtDetailState(this.detailTitle,this.detailId);
  }
}

class _ThoughtDetailState extends State<ThoughtDetail>{
  String detailTitle;
  int detailId;
  _ThoughtDetailState(this.detailTitle,this.detailId);

  bool isLoading = true;
  bool isPlaying = false;
  var nowPlaying = "";
  var title = "";
  var thoughtContent = "";
  var audioFile;
  var audioUrl = "";
  AudioPlayer audioPlayer = AudioPlayer();
  List items = [];
  IconData playBtn = Icons.play_circle_fill_outlined;

  _fetchData() async{
    final url = "http://157.230.214.75/api/thoughtlist/$detailId";
    final response = await http.get(url);
    if(response.statusCode == 200){
      var jsonData = json.decode(response.body);
      var thought2day = jsonData;
      title = thought2day['title'];
      thoughtContent = thought2day['post_content'];
      audioFile = thought2day['audio_content'];
    }

    setState(() {
      isLoading = false;
    });
  }

  _playAudio() async{
    await audioPlayer.play(audioFile);
  }

  _pauseAudio() async{
    await audioPlayer.pause();
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
      drawer: MyDrawer(),
      body: isLoading ? MyLoading() : CustomScrollView(
        slivers: [
          SliverAppBar(
            // title: Text("Thought Today"),
            pinned: true,
            expandedHeight: 100.0,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top:10.0,left: 10.0),
                child: Text(detailTitle,style: TextStyle(fontSize: 10.0),),
              ),
            ),
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
          SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(detailTitle,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(thoughtContent),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Listen to audio content below"),
                    Text(nowPlaying,style: TextStyle(fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                  ],
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(playBtn,size: 50.0,),
                      onPressed: () {
                        if(!isPlaying){
                          setState(() {
                            playBtn = Icons.pause_circle_outline_rounded;
                            isPlaying = true;
                            nowPlaying = "playing";
                            _playAudio();
                          });
                        }
                        else{
                          setState(() {
                            playBtn = Icons.play_circle_outline_outlined;
                            isPlaying = false;
                            nowPlaying = "paused";
                            _pauseAudio();
                          });
                        }
                      },
                    )
                  ],
                )
              ])
          )
        ],
      ),
    );
  }


}