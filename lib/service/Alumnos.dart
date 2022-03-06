import 'package:http/http.dart' as http;


Future<http.Response> addAlumno(String nombre,String apellidos, String genero,String telefono,String direccion,int idGrupo){
  String id=idGrupo.toString();
  return http.post(Uri.parse("http://localhost:3525/Addalumno"),body:{'nombre':nombre,'apellidos':apellidos,'telefono':telefono,'genero':genero,'direccion':direccion,'idGrupo':id});
}

Future<http.Response> updateAlumnoService(int id,String nombre,String apellidos,String telefono,String direccion,String genero,int idGrupo){
  String id2=id.toString();
  return http.put(Uri.parse("http://localhost:3525/Updatealumno/$id2"),body:{'nombre':nombre,'apellidos':apellidos,'telefono':telefono,'genero':genero,'direccion':direccion,'idGrupo':idGrupo.toString()});
}
