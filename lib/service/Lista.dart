import 'package:http/http.dart' as http;


Future<http.Response> listaAlumnos(int id){
  String id2=id.toString();
  return http.get(Uri.parse("http://localhost:3525/Lista/${id2}"));
}
Future<http.Response> listaMaterias(int id){
  String id2=id.toString();
  return http.get(Uri.parse("http://localhost:3525/ListaMateria/${id2}"));
}
