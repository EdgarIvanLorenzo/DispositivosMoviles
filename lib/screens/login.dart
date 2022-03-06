import 'package:flutter/material.dart';
import 'package:project_school/screens/home.dart';


class Login extends StatelessWidget{
  final user=TextEditingController();
  final password=TextEditingController();
  final formValid=GlobalKey<FormState>();

  Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child:Container(
          width: 300,
          child: Form(
            key:formValid,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),
              
              Padding(
                padding:EdgeInsets.all(10),
                child:TextFormField(
                validator:(value){
                    if(value==null || value.isEmpty){
                      return "Usuario incorrecto";
                    }
                },
                controller:user,
                style:TextStyle(fontSize:20,color:Colors.black),
                decoration:   InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                     ),
                  icon: Icon(Icons.accessibility,color:Colors.cyan),
                  label: Text("Usuario",style:TextStyle(fontSize: 20,color: Colors.black))
                ),
              ),

              
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  validator:(value){
                    if(value==null || value.isEmpty){
                      return 'Contraseña incorrecto';
                    }
                  },
                  controller:password,
                  style:TextStyle(fontSize:20,color:Colors.black),
                  obscureText: true,
                  decoration:  InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:  const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                     ),
                    icon:Icon(Icons.accessibility,color:Colors.cyan),
                    label:Text("Contraseña",style:TextStyle(fontSize: 20,color: Colors.black))
                  ),
                ),
              ),


              //Boton
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  //Todo estilos de boton
                  style:ButtonStyle(
                    backgroundColor:MaterialStateProperty.all(Colors.cyan),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(color: Colors.white)
                            )
                        )
                  ),
                  onPressed: (){
                    if(formValid.currentState!.validate()) {
                      //Crear la ruta
                      Route home=MaterialPageRoute(
                        builder: (BuildContext context)=>Home()
                      );
                      Navigator.push(context, home);
                    }
                  },
                  child:Text("Ingresar",style:TextStyle(fontSize: 20,color: Colors.black)),
                ),
              )
            ],
          ),
          ),
        )
      )
    );
  }

}