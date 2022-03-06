import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> getMaterias() async{
  return await  http.get(Uri.parse("http://localhost:3525/Allmaterias"));
}

Future<http.Response> updateMaterias(int id,String nombre)async{
  String id2=id.toString();
  return await http.put(Uri.parse("http://localhost:3525/Updatemateria/$id2"),body:{'id':id2,'nombre':nombre});
}


Future<http.Response> addMaterias(String nombre)async{
  return await http.post(Uri.parse("http://localhost:3525/Addmateria"),body:{'nombre':nombre});
}

Future<http.Response> deleteMateria(int id)async{
  String id2=id.toString();
  return await http.delete(Uri.parse("http://localhost:3525/Deletemateria/$id2"));
}