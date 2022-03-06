import 'package:flutter/material.dart';
import 'package:project_school/screens/Listas/datosGrupos.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class HomeListas extends StatefulWidget{
  const HomeListas({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState()=>_HomeListas();
}

class _HomeListas extends State<StatefulWidget>{
  List<dynamic> grupos=[];
  //creacion del mapa
   Map<String,bool> drawer={
    'materia':false,
    'grupos':false,
    'alumnos':false,
    'carga':false,
    'lista':true
  };
  //Metodo construtor
  _HomeListas(){
    Inicializador();
  }

  Inicializador()async{
    final response =  await getGrupos();  
    setState((){
      this.grupos =  json.decode(response.body);
    });  
  }
  @override
  Widget build(BuildContext context) {
  List<ElevatedButton> template=botones(context,this.grupos);
   return Scaffold(
     appBar: AppBar(
       title:Text("Grupos"),
       elevation:12
     ),
     drawer:DrawerD.select(select:drawer),
     body:GridView.count(
       primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
       children: template
      ),
   );
  }

}

List<ElevatedButton> botones(BuildContext context, List lista){
  List<ElevatedButton> ListBotones=[];
  for (int i=0;i<lista.length;i++){
    ListBotones.add(
      ElevatedButton(
            style:ButtonStyle(
              backgroundColor:MaterialStateProperty.all(Colors.white),
              elevation:MaterialStateProperty.all(12),
              shadowColor:MaterialStateProperty.all(Colors.black)
            ),
            onPressed: (){
              int id=lista[i]['idGrupo'];
              Route details=MaterialPageRoute(builder: (BuildContext c)=>detailsGroup(idGrupo:id));
              Navigator.push(context, details);
            }, 
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${lista[i]['Grado']} ${lista[i]['Grupo']}",style:TextStyle(fontSize:25)),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset("images/personas.png",height:50),
              )
            ],
            )
          )
    );
  }
  return ListBotones;
}