import 'package:flutter/material.dart';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


class RecuperarClave extends StatefulWidget {
  RecuperarClave({Key key, this.title}) : super(key: key);

  final String title;

  @override
  RecuperarClaveState createState() => RecuperarClaveState();
}

class RecuperarClaveState extends State<RecuperarClave> {

  var email = TextEditingController();

  Color ColorLineaExtMail = Colors.white;
  Color ColorFocusExtMail = globals.ColorAzulTema;
  String eMailString = "¿Cuál es tu email?";


  recuperarClave(String email) async
  {


    await _auth.sendPasswordResetEmail(email: email);

    Fluttertoast.showToast(
        msg: "Se envio un link a tu correo para reconfigurar tu contraseña",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
        fontSize: 15.0
    );

  }

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return  /*Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: globals.gradienteback,
          begin:  FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter
      )
      ),
    height: MediaQuery.of(context).size.height,
    child:*/ Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFFffffff).withOpacity(0.0),
              leading:

              Container(
                width: 80,
                height: 40,
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.transparent,
                      //textStyle: TextStyle(color: Colors.white),
                      elevation: 0.0,
                    ),
                    child: Icon(Icons.arrow_back_ios_rounded, color: globals.ColorMorado),
                    onPressed: () {
                      Navigator.pop(context);
                    }
                  ),
                ),
              ),

        ),
        body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: SingleChildScrollView(
                  child: Column(
                      children: <Widget>[
                        SizedBox(height: 20),
                        Container(
                            height: 240,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.transparent,
                            child: Center(
                              child: Container(
                                color: Colors.transparent,
                                width: 311,
                                child: Column(
                                  children: <Widget>[
                                    SizedBox(height: 26,),
                                    Text('Consejo:\nUn trozo de chocolate por la\nmañana mejora la memoria',
                                        textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Roboto', color: Color(0xFF315F79), fontSize: 24.0)),
                                    SizedBox(height: 18,),
                                    Text('Por lo pronto te enviaremos una\nliga a la cuenta de email que\nregistraste para que puedas\ncolocar una contraseña nueva',
                                      textAlign: TextAlign.center, style: TextStyle(fontFamily: 'Roboto', color: Colors.grey, fontSize: 20.0),),
                                  ],
                                ),
                              ),
                            )
                        ),
                        SizedBox(height: 49,),
                        Container(
                            width: 294,
                            height: 40,
                            child: TextField(
                                controller: email,
                                obscureText: false,
                                style: globals.style,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: eMailString,//"¿Cual es tu email?",
                                    hintStyle: globals.HintStyle,
                                )
                        )
                        ),
                        SizedBox(height: 25,),
                        Center(
                          child: Container(
                            width: 294,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: RaisedButton(
                              color: Colors.transparent,
                              elevation: 0,
                              onPressed: (){

                                if (!email.text.isEmpty)
                                {
                                  Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regex = new RegExp(pattern);

                                  if (!regex.hasMatch(email.text.trim()))
                                  {
                                    email.clear();
                                    ColorLineaExtMail = Colors.red;
                                    ColorFocusExtMail = Colors.red;
                                    eMailString = "email mal escrito";
                                    email.text = "";
                                  }

                                  else
                                    {
                                      ColorLineaExtMail = Colors.white;
                                      ColorFocusExtMail = globals.ColorAzulTema;
                                      recuperarClave(email.text);
                                    }

                                }

                                else
                                {
                                  email.clear();
                                  ColorLineaExtMail = Colors.red;
                                  ColorFocusExtMail = Colors.red;
                                  eMailString = "Falta email";
                                  email.text = "";
                                }

                                setState(() {});
                              },
                              child:  Text('Enviar link', style: TextStyle(color: Color(0xFF8F8F8F), fontSize: 18.0)),
                            ),
                          ),
                        ),
                        SizedBox(height: 60,),
                      ],
                    )



              )
          ),
        //)
      );
  }

}