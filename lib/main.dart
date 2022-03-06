import 'package:flutter/material.dart';
import 'package:project_school/screens/Alumnos/addAlumno.dart';
import 'package:project_school/screens/CargaMaterias/carga.dart';
import 'package:project_school/screens/Grupos/Menugrupos.dart';
import 'package:project_school/screens/Listas/listasHome.dart';
import 'package:project_school/screens/Materias/materias.dart';
import 'package:project_school/screens/Materias/updateMaterias.dart';
import 'package:project_school/screens/home.dart';
import 'package:project_school/screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes:{
        '/Home': (context) =>  Home(),
        '/materias': (context) =>  Materias(),
        '/grupos':(context)=> Grupos(),
        '/alumnos':(context)=> Alumno(),
        '/carga':(context)=>CargaMateria(),
        '/listas':(context)=>HomeListas(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
      home: Login(), 
    );
  }
}
