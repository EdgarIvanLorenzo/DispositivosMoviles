import 'package:flutter/material.dart';
import 'package:project_school/screens/Grupos/Menugrupos.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/service/Grupos.dart';
import 'package:project_school/service/Materias.dart';

class updateGroup extends StatelessWidget{
  final gradoText=TextEditingController();
  final grupoText=TextEditingController();
  final form=GlobalKey<FormState>();

  int grado;
  int grupo;
  int idGrupo;
  updateGroup({Key? key,required this.idGrupo,required this.grado,required this.grupo}) : 
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Update Group"),
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
                    hintText:"$grado",
                    label:Text("Ingrese el grado"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                     )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Ingrese una grado";
                    }
                  },
                ),
                TextFormField(
                  style:TextStyle(color:Colors.black,fontSize:20),
                  controller:grupoText,
                  decoration:InputDecoration(
                    hintText:"$grupo",
                    label:Text("Ingrese el grupo"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                     )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Ingrese un grupo";
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
                            updateGrupos(this.idGrupo,gradoText.text,grupoText.text)
                            .then((value) {
                               Route subjects=MaterialPageRoute(builder: (BuildContext c)=>Grupos());
                              Navigator.push(context,subjects);
                            });
                          }
                        },
                        child: Text("Update",style:TextStyle(color:Colors.white))
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