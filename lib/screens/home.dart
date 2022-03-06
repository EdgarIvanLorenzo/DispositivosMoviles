import 'package:flutter/material.dart';
import 'package:project_school/screens/drawer.dart';

class Home extends StatelessWidget{
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Home"),
        elevation: 12,
      ),
      drawer: DrawerD(),
      body:Center(
        child:Container(
          width:300,
          child:Image.asset('images/logo.png')
        )
      )
    );
  }

}