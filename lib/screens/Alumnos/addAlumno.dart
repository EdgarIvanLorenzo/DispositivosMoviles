import 'package:flutter/material.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/service/Alumnos.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Alumno extends StatefulWidget{
  const Alumno({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Alumno();

}

class _Alumno extends State<StatefulWidget>{
  final form=GlobalKey<FormState>();
  final nombre=TextEditingController();
  final apellidos=TextEditingController();
  final telefono=TextEditingController();
  final direccion=TextEditingController();

  //creacion del mapa
   Map<String,bool> drawer={
    'materia':false,
    'grupos':false,
    'alumnos':true,
    'carga':false,
    'lista':false
  };
  String genero='Hombre';
  int grupo=2;
  List<dynamic> grupos=[];

  //Metodo constructor
  _Alumno() {
    Inicializador();
  }
  //Metodo de inicalizacion
  void Inicializador() async{
    final response =  await getGrupos();  
    setState((){
      this.grupos =  json.decode(response.body);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Alumnos"),
        elevation:12
      ),
      drawer:DrawerD.select(select:drawer),
      body:Center(
        child:Container(
          width:310,
          child:Form(
            key:form,
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Ingrese un nombre';
                      }
                    },
                    controller:nombre,
                    //Color del texto
                    style:TextStyle(fontSize:20,color:Colors.black),
                    //todo Decoracion del input
                    decoration:InputDecoration(
                      hintText:"Nombre alumno",
                      label:Text("Ingrese el nombre",style:TextStyle(color:Colors.grey)),
                      //!Border al seleccionarse
                      focusedBorder: OutlineInputBorder(
                        //!Color borde al focus
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                       ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Ingrese un apellido';
                      }
                    },
                    controller: apellidos,
                    //Color del texto
                    style:TextStyle(fontSize:20,color:Colors.black),
                    //todo Decoracion del input
                    decoration:InputDecoration(
                      hintText:"Apellidos alumno",
                      label:Text("Ingrese los apellidos",style:TextStyle(color:Colors.grey)),
                      //!Border al seleccionarse
                      focusedBorder: OutlineInputBorder(
                        //!Color borde al focus
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                       ),
                    )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.00),
                  child:DropdownButton<String>(
                    //!Metodo para el cambio de valor
                    onChanged:(value){
                       setState((){
                          //Valor distinto a null
                        this.genero=value!;
                       });
                    },
                    value:genero,
                    items:<String>['Hombre', 'Mujer']
                      .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style:TextStyle(fontSize:20)),
                          );
                       }).toList(),
                  ) 
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Ingrese un telefono';
                      }
                    },
                    controller:telefono,
                    //Color del texto
                    style:TextStyle(fontSize:20,color:Colors.black),
                    //todo Decoracion del input
                    decoration:InputDecoration(
                      hintText:"Telefono alumno",
                      label:Text("Ingrese el telefono",style:TextStyle(color:Colors.grey)),
                      //!Border al seleccionarse
                      focusedBorder: OutlineInputBorder(
                        //!Color borde al focus
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                       ),
                    )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value){
                      if(value==null||value.isEmpty){
                        return 'Ingrese una direccion';
                      }
                    },
                    controller:direccion,
                    //Color del texto
                    style:TextStyle(fontSize:20,color:Colors.black),
                    //todo Decoracion del input
                    decoration:InputDecoration(
                      hintText:"Ciudad del alumno",
                      label:Text("Ingrese la ciudad",style:TextStyle(color:Colors.grey)),
                      //!Border al seleccionarse
                      focusedBorder: OutlineInputBorder(
                        //!Color borde al focus
                        borderSide: const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                       ),
                    )
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10.00),
                  child: DropdownButton<dynamic>(
                    onChanged:(value){
                        setState((){
                          grupo=value!;
                        });
                    },
                    value: grupo,
                    items: lista(context,this.grupos)
                  ),
                ),


                //!Boton
                Padding(
                  padding: EdgeInsets.all(10.00),
                  child: ElevatedButton(
                    onPressed: (){
                        //Validacion del formulario
                        if(form.currentState!.validate()){
                          String n=nombre.text;
                          String a=apellidos.text;
                          String t=telefono.text;
                          String d=direccion.text;
                          //Peticion
                          addAlumno(n, a, genero, t, d, grupo)
                          .then((value){
                            if(value!=null){
                              showDialog(
                                context: context,
                                 builder: (BuildContext c){
                                   return const AlertDialog(
                                     title: Text("Alumno agregado"),
                                   );
                                 }
                              ); 
                            }
                            
                            nombre.text="";
                            apellidos.text="";
                            telefono.text="";
                            direccion.text="";
                          });
                         
                        }
                    }, 
                    child: Text("Aguardar",style:TextStyle(fontSize:20)),
                    style:ButtonStyle(
                      backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                    )
                  ),
                ),
              ]
            )
          )
        )
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