import 'package:flutter/material.dart';
import 'package:project_school/screens/Materias/updateMaterias.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/service/Materias.dart';

class Option extends StatelessWidget{
  int id;
  String nombre;
  Option({Key? key,required this.id, required this.nombre}) : super(key: key);

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
            Route updateM=MaterialPageRoute(builder: (BuildContext c)=>updateBook(idLibro: id, nombre: nombre));
            Navigator.push(context, updateM);
          },
          enableFeedback:true,
        ),
        ListTile(
          title:Text("Delete",style:TextStyle(color:Colors.black)),
          //Metodo Ontap al precionar
          onTap: (){
            deleteMateria(id)
            .then((value){
              //Cerramos el punto de navegacion
              Navigator.of(context).popAndPushNamed("/materias");
            });
          },
          enableFeedback:true,
        )
          ]
        ),
      )
    );
  }

}