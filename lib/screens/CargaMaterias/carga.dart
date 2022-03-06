import 'package:flutter/material.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/service/CargaMaterias.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:project_school/service/Materias.dart';

class CargaMateria extends StatefulWidget{
  //Metodo constructor
  const CargaMateria({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CargaMateria();

}

class _CargaMateria extends State<StatefulWidget> {
  //creacion del mapa
   Map<String,bool> drawer={
    'materia':false,
    'grupos':false,
    'alumnos':false,
    'carga':true,
    'lista':false
  };
  Map<String,bool> selectCheck={};
  int grupo=1;
  List<dynamic> grupos=[];
  List<dynamic> materias=[];
  List<int> selectMaterias=[];

  //Todo Metodo constructor
  _CargaMateria(){
    Inicializador1();
    Inicializador2();
  }

   //Metodo de inicalizacion
  void Inicializador1() async{
    final response =  await getGrupos();  
    setState((){
      this.grupos =  json.decode(response.body);
    });
  }
  void Inicializador2()async{
    final response=await getMaterias();
    setState(() {
      this.materias=json.decode(response.body);
      //Cargar los datos al CheckBox
      for(int i=0;i<materias.length;i++){
        this.selectCheck[materias[i]['Nombre']]=false;
      }
    });
  }

  //Sobreescritura del metodo build el cual retorna un Widget
  @override
  Widget build(BuildContext context) {
    //Retorno del Widget
    return Scaffold(
      appBar:AppBar(
        title:Text("Carga Materias")
      ),
      drawer:DrawerD.select(select:drawer),
      body:Center(
        child:Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
               Padding(
                  padding: EdgeInsets.all(10.00),
                  child: DropdownButton<dynamic>(
                    onChanged:(value){
                        setState((){
                          grupo=value!;
                          print(grupo);
                        });
                    },
                    value: grupo,
                    items: lista(context,this.grupos)
                  ),
                ),
                Column(
                  children:selectCheck.keys.map((String key) {
                      return new CheckboxListTile(
                          title: Text(key),
                          value: selectCheck[key],
                          onChanged: (bool? value) {
                          setState(() {
                            for(int i=0;i<materias.length;i++){
                              if(materias[i]['Nombre']==key && value==true){
                                this.selectMaterias.add(materias[i]['idMateria']);
                              }else if(value==false && materias[i]['Nombre']==key){
                                     this.selectMaterias.remove(materias[i]['idMateria'].toString());
                              }
                            }
                            selectCheck[key] = value!;
                          });
                        },
                      );
                   }).toList(),
              ),
            ]
          )
        )
      ),
      floatingActionButton:FloatingActionButton(
        onPressed: (){
          final materiaArreglo=selectMaterias;
          cargaMateria(grupo,materiaArreglo)
          .then((value){
            if(value!=null){
              showDialog(context: context, 
                builder:(BuildContext context)=>AlertDialog(title: Text("Carga realizada"),)
              );
            }
          });
        },
        child:Icon(Icons.add)
      )
    );
  }
}

List<DropdownMenuItem> lista(BuildContext context,List<dynamic> lista1){
  List<DropdownMenuItem> l=[];
  for (int i=0;i<lista1.length;i++){
    int valor=lista1[i]['idGrupo'];
    l.add(
       DropdownMenuItem(
          child: Text("${lista1[i]['Grado']} ${lista1[i]['Grupo']}",style:TextStyle(fontSize:20)),
          value: valor,
      ),
    );
  }
  return l;
}

