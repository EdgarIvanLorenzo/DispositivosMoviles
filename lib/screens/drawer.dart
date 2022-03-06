import 'package:flutter/material.dart';
import 'package:project_school/screens/Grupos/Menugrupos.dart';
import 'package:project_school/screens/login.dart';
import 'package:project_school/screens/Materias/materias.dart';

class DrawerD extends StatelessWidget{
   //Mapa para seleccionar la Ruta
  Map<String,bool> select={
      'materia':false,
      'grupos':false,
      'alumnos':false,
      'carga':false,
      'lista':false
    };
  DrawerD({Key? key,}):
    this.select ={
      'materia':false,
      'grupos':false,
      'alumnos':false,
      'carga':false,
      'lista':false
    },
    super(key: key);

  DrawerD.select( {Key? key,required this.select}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(

      child: Drawer(
          child:ListView(
            //Todo quitar el marco para que el color se respalde desde padding 0
            padding: const EdgeInsets.all(0.0),
            children:  [
              //todo Titulo del drawer Help
              DrawerHeader(
                decoration:const BoxDecoration(
                  color:Colors.cyan,
                ),
                child: Image.asset("images/logo.png"),
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap:(){
                    Navigator.popAndPushNamed(context, '/materias');
                  },
                  title:Text("Materia",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
                  selected: this.select['materia']!,
                  //Icono al final de la fila
                  trailing: Icon(Icons.auto_stories_outlined),
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap:(){
                    Navigator.popAndPushNamed(context,'/grupos');
                  },
                  title:Text("Grupos",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
                  trailing: Icon(Icons.boy_outlined),
                  selected:this.select['grupos']!
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap:(){
                    Navigator.popAndPushNamed(context,'/alumnos');
                  },
                  title:Text("Alumnos",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
                  trailing: Icon(Icons.attribution),
                  selected:this.select['alumnos']!
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap:(){
                    //Navegacion a la ruta
                    Navigator.popAndPushNamed(context,'/carga');
                  },
                  title:Text("Carga Materias",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
                  trailing: Icon(Icons.book_online),
                  selected:this.select['carga']!
                ),
              ),


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  onTap:(){
                    Navigator.popAndPushNamed(context,'/listas');
                  },
                  title:Text("Lista",style:TextStyle(color:Colors.black,fontSize:20,fontFamily:"Arial")),
                  trailing: Icon(Icons.auto_awesome_mosaic_outlined),
                  selected:this.select['lista']!
                ),
              ),

              Padding(
                padding:const EdgeInsets.only(left:65,top:240,right:70,bottom:0),
                child:ElevatedButton(
                  style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)
                            )
                        )
                        ),
                  onPressed: (){
                    //Salir de la sesion
                    Route login=MaterialPageRoute(builder: (BuildContext c)=>Login());

                    Navigator.push(context,login);
                  },
                  child:Text("Cerrar sesion",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold,fontSize:18)),
                )
              )
              
            ],
          )
        ),
    );
  }

}