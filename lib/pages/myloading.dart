import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class MyLoading extends StatefulWidget{

  @override
  _MyLoadingState createState() => _MyLoadingState();
}

class _MyLoadingState extends State<MyLoading> {

  bool hasInternet = false;
  _checkConnectivity() async{
    var result = await Connectivity().checkConnectivity();
    switch(result){
      case ConnectivityResult.none:
        {
          hasInternet = false;
          return Text("You are not connected to the internet");
        }
        break;
      case ConnectivityResult.mobile:
        {
          hasInternet = true;
        }
        break;
      case ConnectivityResult.wifi:
        {
          hasInternet = true;
        }
        break;
    }
  }

  @override
  void initState(){
    super.initState();
    setState(() {
      _checkConnectivity();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
    child: hasInternet ? CircularProgressIndicator() : Text("Checking your internet connection please wait")

    );
  }
}