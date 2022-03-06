import 'package:flutter/material.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/service/Materias.dart';

class updateBook extends StatelessWidget{
  final nombreText=TextEditingController();
  final form=GlobalKey<FormState>();

  String nombre;
  int idLibro;
  updateBook({Key? key,required this.idLibro,required this.nombre}) : 
  super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Update Books"),
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
                  controller:nombreText,
                  decoration:InputDecoration(
                    hintText:"$nombre",
                    label:Text("Ingrese la materia"),
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(20.0),
                     )
                  ),
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Ingrese una nombre";
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
                          print(nombreText.text);
                          Navigator.pop(context);
                        },
                      child: Text("Cancel",style:TextStyle(color:Colors.white))
                      ),
                      RaisedButton(
                        color:Colors.blue,
                        onPressed: (){
                          if(form.currentState!.validate()){
                            updateMaterias(idLibro, nombreText.text)
                            .then((value) {
                              Route subjects=MaterialPageRoute(builder: (BuildContext c)=>Materias());
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