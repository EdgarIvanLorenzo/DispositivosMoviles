import 'package:flutter/material.dart';
import 'package:project_school/screens/drawer.dart';
import 'package:project_school/service/Alumnos.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class updateAlumno extends StatefulWidget{
  String nombre,apellidos,telefono,ciudad,genero;
  int idGrupo,idAlumno;
  updateAlumno({Key? key,required this.idAlumno,required this.nombre,required this.apellidos,required this.telefono,required this.ciudad,required this.genero,required this.idGrupo}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Alumnod(idAlumno:idAlumno,nombre1:nombre,apellidos1:apellidos,telefono1:telefono,ciudad1:ciudad,genero1:genero,idGrupo:idGrupo);

}

class _Alumnod extends State<StatefulWidget>{
  String nombre1,apellidos1,telefono1,ciudad1,genero1;
  final form=GlobalKey<FormState>();
  final nombre=TextEditingController();
  final apellidos=TextEditingController();
  final telefono=TextEditingController();
  final direccion=TextEditingController();
  String genero="";
  int idGrupo=0,idAlumno;
  List<dynamic> grupos=[];

  //creacion del mapa
   Map<String,bool> drawer={
    'materia':false,
    'grupos':false,
    'alumnos':true,
    'carga':false,
    'lista':false
  };

  //Metodo constructor
  _Alumnod({required this.idAlumno,required this.nombre1,required this.apellidos1,required this.telefono1,required this.ciudad1,required this.genero1,required this.idGrupo}){
    Inicializador();
    this.genero=genero1;
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
    print(idAlumno);
    return Scaffold(
      appBar: AppBar(
        title:Text("Actualizar"),
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
                      hintText:"$nombre1",
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
                      hintText:"$apellidos1",
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
                      hintText:"$telefono1",
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
                      hintText:"$ciudad1",
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
                          idGrupo=value!;
                        });
                    },
                    value: idGrupo,
                    items: lista(context,this.grupos)
                  ),
                ),

                //!Boton
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){
                          Navigator.pop(context);
                      }, 
                      child: Text("Cancelar",style:TextStyle(fontSize:20)),
                      style:ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.red),
                      )
                    ),
                    ElevatedButton(
                      onPressed: (){
                          //Validacion del formulario
                          if(form.currentState!.validate()){
                            String n=nombre.text;
                            String a=apellidos.text;
                            String t=telefono.text;
                            String d=direccion.text;
                            updateAlumnoService(this.idAlumno, n, a, t,d,genero, idGrupo)
                            .then((value){
                              if(value!=null){
                                showDialog(
                                  context: context,
                                   builder: (BuildContext context)=>AlertDialog(
                                     title:const Text("Alumno actualizado")
                                   )
                                );
                              }
                            nombre.text="";
                            apellidos.text="";
                            telefono.text="";
                            direccion.text="";
                            });
                           
                          }
                      }, 
                      child: Text("Actualizar",style:TextStyle(fontSize:20)),
                      style:ButtonStyle(
                        backgroundColor:MaterialStateProperty.all<Color>(Colors.blue),
                      )
                    ),
                  ],
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