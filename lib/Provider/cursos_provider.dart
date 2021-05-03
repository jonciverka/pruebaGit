import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ninosdeahora/Modelos/ApartadosCurso.dart';
import 'package:ninosdeahora/Modelos/Cursos.dart';

class CursosProvider{
  String _url = "ninosdeahora.online";

  Future obtenerCursos() async{    
    final url = Uri.https(_url,'/api/obtenerCursos');
    final resp =   await http.get(url, headers: {"token": "eyJhbGciOiJIUzI1NiJ9.MjEzMQ.GMriQhVg0SsENBY2sroi9C50tPREmWXSo3q8LKrK4VM"}).timeout(const Duration(seconds: 10));
    final decodedData =  jsonDecode(resp.body);
    final cursos = new Cursos.fromJsonList(decodedData);
    return cursos.items;
  }
  Future obtenerApartadosCurso(pkCurso) async{  
    final url = Uri.https(_url,'/api/obtenerApartadosCurso',{
      'pkCurso': pkCurso.toString(),
    });
    final resp =   await http.get(url, headers: {"token": "eyJhbGciOiJIUzI1NiJ9.MjEzMQ.GMriQhVg0SsENBY2sroi9C50tPREmWXSo3q8LKrK4VM"}).timeout(const Duration(seconds: 10));
    final decodedData =  jsonDecode(resp.body);
    final apartados = new ApartadosCursos.fromJsonList(decodedData);
    return apartados.items;
  }

  
}