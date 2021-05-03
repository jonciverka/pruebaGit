class Register{

  String mensaje;
  int status;

  Register();

  Register.fromJson(dynamic json){

      mensaje = json['mensaje'];
      status = json['status'];

  }

}