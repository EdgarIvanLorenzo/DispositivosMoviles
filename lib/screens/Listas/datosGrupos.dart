import 'package:flutter/material.dart';
import 'package:project_school/screens/Listas/datosAlumnos.dart';
import 'package:project_school/service/Lista.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class detailsGroup extends StatefulWidget{
  int idGrupo;
  detailsGroup({Key? key,required this.idGrupo}) : super(key: key);

  @override
  State<StatefulWidget> createState()=> _detailsGroup(idGrupo:this.idGrupo);

}

class _detailsGroup extends State<StatefulWidget>{
  int idGrupo;
  List<dynamic> datosAlumnos=[];
  List<dynamic> datosMaterias=[];

  _detailsGroup({Key? key,required this.idGrupo}){
    Inicializador1();
    Inicializador2();
  }

  Inicializador1()async{
    final resultado=await listaAlumnos(this.idGrupo);
    setState((){
      //Convercion de los datos
      this.datosAlumnos= json.decode(resultado.body);
    });
  }
  Inicializador2()async{
    final resultado=await listaMaterias(this.idGrupo);
    setState((){
      //Convercion de los datos
      this.datosMaterias= json.decode(resultado.body);
    });
  }


  @override
  Widget build(BuildContext context) {
    print(this.datosAlumnos);    
    List<Widget> template1=templateAlumnos(context,this.datosAlumnos);
    List<Widget> template2=templateMaterias(context,this.datosMaterias,template1);
    if(template2.length==0){
      template2.add(
        Padding(padding:EdgeInsets.fromLTRB(0,300,0,0),child: Text("No existe ningun dato",style:TextStyle(color:Colors.red,fontSize:30,fontWeight:FontWeight.bold),textAlign: TextAlign.center,))
      );
    }
    return Scaffold(
      appBar:AppBar(
        title:Text("Detalles"),
        elevation: 12,
      ),
      body:ListView(
        shrinkWrap:true,
        children:template2
      )
    );
  }

}

List<Widget> templateAlumnos(BuildContext c,List l){
  List<Widget> alumnos=[];
  if(l.length!=0){
  alumnos.add(Padding(
    padding: const EdgeInsets.all(10.0),
    child: Text("Alumnos",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center,),
  ));
  for(int i=0;i<l.length;i++){
    alumnos.add(
      ListTile(
        title:Text("${l[i]['Nombre']} ${l[i]['Apellidos']}",style: TextStyle(fontSize: 20,color:Colors.black,fontFamily: 'Arial'),textAlign:TextAlign.center),
        onTap:(){
          showDialog(
            context: c, 
            builder: (BuildContext c)=>dataAlumn(idAlumno:l[i]['id'],nombre: l[i]['Nombre'], apellidos: l[i]['Apellidos'], telefono: l[i]['Telefono'], direccion: l[i]['Direccion'],genero:l[i]['Genero'],id:l[i]['idGrupo'])
          );
        }
      )
    );
  }
  }
  
  return alumnos;
}

List<Widget> templateMaterias(BuildContext c,List l,List<Widget>l2){
  List<Widget> materias=l2;
  if(l.length!=0){
    materias.add(Padding(
    padding: const EdgeInsets.fromLTRB(10, 50, 10, 10),
    child: Text("Materias",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color:Colors.black),textAlign: TextAlign.center,),
  ));
  for(int i=0;i<l.length;i++){
    materias.add(
      ListTile(
        title:Text("${l[i]['Nombre']}",style: TextStyle(fontSize: 20,color:Colors.black,fontFamily: 'Arial'),textAlign:TextAlign.center),
        onTap:(){
          print("Hola");
        }
      )
    );
  }
  }
  return materias;
}