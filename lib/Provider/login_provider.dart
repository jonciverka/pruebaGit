import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../globals.dart' as globals;
import 'package:ninosdeahora/Modelos/LoginMod.dart';

class LoginProvider{
  String _url = "ninosdeahora.online";

  loginServer(String idToken, String uid) async{

    final url = Uri.https(globals.baseurl, "/api/login", {"idToken": idToken, "uid": uid});

    final response = await http.post(url, headers: {"Content-Type": "application/json"}).timeout(
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

    print("........ Login serv: ${response.body}");

    final decodedData = jsonDecode(response.body);

    final login = Login.fromJson(decodedData);

    return login;


  }



}