import 'package:flutter/material.dart';
import 'package:project_school/screens/Materias/addMateria.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/screens/Materias/option.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:project_school/service/Materias.dart';

class Materias extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _Materias();

}

class _Materias extends State<StatefulWidget>{

   Map<String,bool> drawer={
    'materia':true,
    'grupos':false,
    'alumnos':false,
    'carga':false,
    'lista':false
  };

  List<dynamic> materias=[];
  _Materias(){
    Inicializador();
  }

  void Inicializador() async{
    final response =  await getMaterias();
    setState((){
      this.materias = json.decode(response.body);
    });
  }
  
  @override
  Widget build(BuildContext context){
    List<Padding> lista1 =lista(context,this.materias);
    return Scaffold(
      appBar: AppBar(
        title:Text("Materias"),
        elevation: 12,
      ),
      drawer:DrawerD.select(select:this.drawer),
      body:ListView(
        children:lista1
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Route addSubject=MaterialPageRoute(builder: (BuildContext c)=>addBook());
          Navigator.push(context,addSubject);
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.add),
      )
    );
  }

}

List<Padding> lista(BuildContext context, List<dynamic> l){
  List<Padding> vista=[];
  for(int i=0;i<l.length;i++){
    vista.add(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap:(){
            showDialog(
              context: context, 
              builder: (BuildContext c)=>Option(id:l[i]['idMateria'],nombre:l[i]['Nombre'])
            );
          },
          title:Text("${l[i]['Nombre']}",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
          trailing: Icon(Icons.auto_stories_outlined),
        ),
      ),
      );
  }

  return vista;
}
