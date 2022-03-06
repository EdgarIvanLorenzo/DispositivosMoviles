import 'package:flutter/material.dart';
import 'package:project_school/screens/Grupos/addGrupo.dart';
import 'package:project_school/screens/Grupos/option.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Grupos extends StatefulWidget {

  Grupos({Key? key}) : super(key: key);

  @override
  State<Grupos> createState() => _GruposState();
}

class _GruposState extends State<Grupos> {
  //!Construccion del mapa
  Map<String,bool> drawer={
    'materia':false,
    'grupos':true,
    'alumnos':false,
    'carga':false,
    'lista':false
  };
  //Creacion de un arreglo
  List<dynamic> grupos=[];

  //Todo metodo constructor
  _GruposState(){
    Inicializador();
  }

  //Metodo para inicializar los datos de tipo asincrono
  void Inicializador() async{
    //Esperamos la respuesta
    final response =  await getGrupos();
    //Cambiamos el estado de la aplicacion
    setState((){
      //!Convertir los datos de la respuesta
      this.grupos = json.decode(response.body);
    });
  }


  @override
  Widget build(BuildContext context) {
    //creacion de un arreglo
    List<Padding> listaGrupo=listaGrupos(context,this.grupos);

    return Scaffold(
      appBar:AppBar(
        title:Text("Grupos"),
        elevation:12
      ),
      drawer: DrawerD.select( select: this.drawer,),
      body: ListView(
        shrinkWrap:true,
        children: listaGrupo, //!Arreglo de tipo Widget
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
            Route addGrupo=MaterialPageRoute(builder: (BuildContext c)=>addGroup());

            Navigator.push(context, addGrupo);
        },
        tooltip: "Agregar Grupo",
        child:Icon(Icons.add),
        elevation:10
      ),
    );
  }
}

//clase para 
List<Padding> listaGrupos(BuildContext context, List<dynamic> l){
  List<Padding> vista=[];
  for(int i=0;i<l.length;i++){ //!Recorrido de la lista por peticion
    vista.add(
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          onTap:(){
           showDialog(
             context: context, 
             builder: (BuildContext c)=> Option(id: l[i]['idGrupo'], grado: l[i]['Grado'],grupo:l[i]['Grado'])
            );
          },
          title:Text("${l[i]['Grado']} ${l[i]['Grupo']}",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
          trailing: Icon(Icons.auto_stories_outlined),
        ),
      ),
      );
  }

  return vista;
}