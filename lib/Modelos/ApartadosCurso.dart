class ApartadosCursos {
  List items = new List.empty(growable: true);
  ApartadosCursos();
  ApartadosCursos.fromJsonList(List<dynamic> jsonList){
    if(jsonList == null) return;
    for(var item  in jsonList){
      final apartadoCursos = new ApartadoCursos.fromJsonMap(item);
      items.add(apartadoCursos);
    }
  }
}

class ApartadoCursos {
  String url;
  int pkApartadoCursos;
  String nombre;

  ApartadoCursos({
    this.url,
    this.pkApartadoCursos,
    this.nombre,
  });
  ApartadoCursos.fromJsonMap(Map<String, dynamic > json){
    url = json['URL_IMAGEN'];
    pkApartadoCursos = json['PK_APARTADO'];    
    nombre = json['NOMBRE'];    
  }

 
}
