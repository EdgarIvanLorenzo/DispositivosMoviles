import 'package:http/http.dart' as http;
import 'dart:convert';

Future<http.Response> getGrupos() async{
  return await  http.get(Uri.parse("http://localhost:3525/Allgrupos"));
}

Future<http.Response> updateGrupos(int id,String grado,String grupo)async{
  String id2=id.toString();
  return await http.put(Uri.parse("http://localhost:3525/Updategrupo/$id2"),body:{'grado':grado,'grupo':grupo});
}


Future<http.Response> addGrupo(String grado,String grupo)async{
  return await http.post(Uri.parse("http://localhost:3525/Addgrupo"),body:{'grado':grado,'grupo':grupo});
}

Future<http.Response> deleteGrupo(int id)async{
  String id2=id.toString();
  return await http.delete(Uri.parse("http://localhost:3525/Deletegrupo/$id2"));
}