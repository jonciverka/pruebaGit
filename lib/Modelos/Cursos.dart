class Cursos {
  List items = new List.empty(growable: true);
  Cursos();
  Cursos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item  in jsonList){
      final curso = new Curso.fromJsonMap(item);
      items.add(curso);
    }
  }
}

class Curso {
  String url;
  String nombre;
  int pkCurso;

  Curso({
    this.url,
    this.pkCurso,
  });
  Curso.fromJsonMap(Map<String, dynamic > json){
    url = json['URL_IMAGEN'];
    pkCurso = json['PK_CURSO'];    
    nombre = json['NOMBRE'];    
  }

 
}
