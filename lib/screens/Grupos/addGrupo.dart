import 'package:flutter/material.dart';
import 'package:project_school/screens/Grupos/Menugrupos.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/service/Materias.dart';

import '../../service/Grupos.dart';

class addGroup extends StatelessWidget{
  final gradoText=TextEditingController();
  final grupoText=TextEditingController();
  final form=GlobalKey<FormState>();

  addGroup({Key? key}) : 
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Add Group"),
      ),
      body:Center(
        child:Container(
          width: 250,
          child:Form(
            key:form,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                TextFormField(
                  style:TextStyle(color:Colors.black,fontSize:20),
                  controller:gradoText,
                  decoration:InputDecoration(
                    hintText:"Grado",
                    label:Text("Ingrese el grado"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                     )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Ingrese un valor";
                    }
                  },
                ),

                TextFormField(
                  style:TextStyle(color:Colors.black,fontSize:20),
                  controller:grupoText,
                  decoration:InputDecoration(
                    hintText:"Grupo",
                    label:Text("Ingrese el grupo"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                     )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Ingrese un valor";
                    }
                  },
                ),
                

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children:[
                      RaisedButton(
                        color:Colors.red,
                        onPressed: (){
                          Navigator.pop(context);
                        },
                      child: Text("Cancel",style:TextStyle(color:Colors.white))
                      ),
                      RaisedButton(
                        color:Colors.blue,
                        onPressed: (){
                          if(form.currentState!.validate()){
                            addGrupo(gradoText.text,grupoText.text)
                            .then((value) {
                              Navigator.of(context).popAndPushNamed('/grupos');
                            });
                          }
                        },
                        child: Text("Add",style:TextStyle(color:Colors.white))
                      )
                    ]
                  ),
                )
              ]
            ),
          )
        )
      )
    );
  }

}