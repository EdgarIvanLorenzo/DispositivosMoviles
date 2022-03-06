import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<http.Response> cargaMateria(int idGrupo, var materias){
  var body = jsonEncode({ 'grupo': idGrupo,'materia':materias});
  return http.post(Uri.parse("http://localhost:3525/Cargamaterias"), headers: {"Content-Type": "application/json"},body:body);
}