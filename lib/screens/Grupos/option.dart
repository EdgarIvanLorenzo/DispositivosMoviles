import 'package:flutter/material.dart';
import 'package:project_school/screens/Grupos/updateGrupos.dart';
import 'package:project_school/screens/Materias/updateMaterias.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:project_school/service/Materias.dart';

class Option extends StatelessWidget{
  int id;
  int grado;
  int grupo;
  Option({Key? key,required this.id, required this.grado,required this.grupo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:const Text("Select option"),
      content: Container(
        height: 120,
        child: Column(
          children:[
            ListTile(
          title:Text("Update",style:TextStyle(color:Colors.black)),
          //Metodo Ontap al precionar
          onTap: (){
           Route updateM=MaterialPageRoute(builder: (BuildContext c)=>updateGroup(idGrupo: id, grado: grado,grupo:this.grupo));
            Navigator.push(context, updateM);
          },
          enableFeedback:true,
        ),
        ListTile(
          title:Text("Delete",style:TextStyle(color:Colors.black)),
          //Metodo Ontap al precionar
          onTap: (){
            deleteGrupo(this.id)
            .then((value) => Navigator.of(context).popAndPushNamed('/grupos'));
          },
          enableFeedback:true,
        )
          ]
        ),
      )
    );
  }

}