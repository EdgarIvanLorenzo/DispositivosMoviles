import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project_school/screens/Alumnos/updateAlumno.dart';

class dataAlumn extends StatelessWidget{
  String nombre,apellidos,telefono,direccion,genero;
  int id,idAlumno;
  dataAlumn({Key? key,required this.idAlumno,required this.nombre,required this.apellidos,required this.telefono,required this.direccion,required this.genero,required this.id}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("${nombre} $apellidos"),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:[
              Image.asset('images/llamada.png'),
              Text("  Telefono $telefono",style:TextStyle(fontSize:15,color:Colors.black))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:[
              Image.asset('images/direccion.png'),
              Text("  Direccion  $direccion",style:TextStyle(fontSize:15,color:Colors.black))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children:[
              Image.asset('images/genero.png'),
              Text("  Genero  $genero",style:TextStyle(fontSize:15,color:Colors.black))
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:[
              ElevatedButton(
                style:ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red)
                ),
                onPressed: (){
                  Route modificar=MaterialPageRoute(builder: (BuildContext context)=>updateAlumno(idAlumno:idAlumno,nombre:nombre,apellidos:apellidos,telefono:telefono,ciudad:direccion,genero:genero,idGrupo:id));
                  Navigator.of(context).pushAndRemoveUntil(modificar, (route) => true);
                }, 
                child: Text("Modificar",style:TextStyle(fontSize:15,color:Colors.white))
              )
          ]),
        )
      ],
    );
  }
}