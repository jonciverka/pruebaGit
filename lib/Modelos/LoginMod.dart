class Login{

  String token;
  String mensaje;
  String correo;
  String nombre;
  int status;

  Login();

  Login.fromJson(dynamic json){

    if(json['token'] != null){

      token = json['token'];
      nombre = json['nombre'];
      mensaje = "";
      correo = json['correo'];
      status = json['status'];

    }else{

      token = "";
      mensaje = json['mensaje'];
      correo = "";
      status = json['status'];

    }

  }

}
