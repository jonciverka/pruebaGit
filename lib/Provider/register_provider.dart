import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../globals.dart' as globals;
import 'package:ninosdeahora/Modelos/RegisterMod.dart';

class RegisterProvider{


  registerServer(String Nombre, String apelliop, String apellidom, String correo, String uid) async {

    print("...${apellidom}");

    final url = Uri.https(globals.baseurl, "/api/registro", {"nombre":Nombre, "apellidoPat":apelliop, "apellidoMat": apellidom,  "correo" : correo, "uid" : uid});

    final response = await http.post(
        url, headers: {"Content-Type": "application/json"}).timeout(
      Duration(seconds: 10),
      onTimeout: () {
        print(".... No hay respuesta del servidor");

        Fluttertoast.showToast(
            msg: "Problema en la conección de internet",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: globals.ColorMorado,
            textColor: Colors.white,
            fontSize: 10.0
        );
        return;
      },
    );

    print("........ Registro serv: ${response.body}");

    final decodedData = jsonDecode(response.body);

    Register register = Register.fromJson(decodedData);

    return register;

  }


}