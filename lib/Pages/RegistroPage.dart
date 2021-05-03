import 'package:flutter/material.dart';
import 'dart:async';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';
import 'package:ninosdeahora/Provider/register_provider.dart';
import 'package:ninosdeahora/Modelos/RegisterMod.dart';
import 'package:ninosdeahora/Widgets/DialogCustom.dart';


class Registro extends StatefulWidget {
  Registro({Key key, this.title}) : super(key: key);

  final String title;

  @override
  RegistroState createState() => RegistroState();
}

class RegistroState extends State<Registro> {

  final Nombre = TextEditingController();
  final ApellidoP = TextEditingController();
  final ApellidoM = TextEditingController();
  final Mail = TextEditingController();
  final Contrasena = TextEditingController();
  final ConfContrasena = TextEditingController();

  Color ColorLineaExtMail = Colors.white;
  Color ColorFocusExtMail = globals.ColorAzulTema;
  String eMailString = "Email";

  Color ColorLineaExtNick = Colors.white;
  Color ColorFocusExtNick = globals.ColorAzulTema;
  String NombreString = "Nombres (s)";
  String ApellidoPString = "Apellido Patero";
  String ApellidoMString = "Apellido Materno";

  Color ColorLineaExtContr = Colors.white;
  Color ColorFocusExtContr = globals.ColorAzulTema;
  String ContrString = "Contraseña";

  Color ColorLineaExtConfContr = Colors.white;
  Color ColorFocusExtConfContr = globals.ColorAzulTema;
  String ConfContrString = "Confirma contraseña";

  OverlayEntry WaitingScreen = globals.createWaitCirculo();

  bool _success;
  String _userEmail = '';

  bool agree = false;

  @override
  void initState() {
    super.initState();

    /*Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });*/


  }




  requestCrearUsuario(String Nombre, String ApellidoP, String ApellidoM, String Email, String Password, String ConfPassword) async {


      try{

        Overlay.of(context).insert(WaitingScreen);


        final auth = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: Email,
          password: Password,
        );

        final User user = await auth.user;

        //WaitingScreen.remove();

        if (user != null) {


          print("................email: ${user.email}");
          print("................UID: ${user.uid}");

          /////////////////  Subir al seridor ////////////////////////////////

          Register valor = await RegisterProvider().registerServer(Nombre, ApellidoP, ApellidoM, user.email, user.uid);

          print(".................Registro: ${valor.mensaje}");


          /*Fluttertoast.showToast(
              msg: "${valor.mensaje}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 15.0
          );*/

          await user.sendEmailVerification();

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('access_token', "unconfirmed");

          await FirebaseAuth.instance.signOut();

          WaitingScreen.remove();

          //Future.delayed(Duration(seconds: 2), (){

            //Navigator.pushNamed(context, '/Confirmail');

            CustomDialog.Show(context, "Cuenta creada exitosamente, favor de revisar tu email para activación de cuenta.", "success");

          //});


        } else {
          _success = false;

        }

      }catch(error){

        print(".......${error.toString()}");

        WaitingScreen.remove();

        if(error.toString().contains("email-already-in-use")){

          /*Fluttertoast.showToast(
              msg: "Email ya esta en uso",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
          );*/

          CustomDialog.Show(context, "Email ya esta en uso.", "warning");


        }

        if(error.toString().contains("key_weaks")){

          /*Fluttertoast.showToast(
            msg: "Contraseña es muy debil",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
          );*/

          CustomDialog.Show(context, "Esta contraseña es muy debil.", "warning");

        }

      }

  }


  @override
  Widget build(BuildContext context) {



    return /*Container(
          decoration: BoxDecoration(gradient: LinearGradient(colors: globals.gradienteback,
          begin:  FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter
      )
    ),
    margin: const EdgeInsets.all(0),
    child:*/ Scaffold(
        backgroundColor: Colors.white,
        body: Stack(

          children: [

            SingleChildScrollView(
                child: Container(
                  //width:  MediaQuery.of(context).size.width*0.9,
                  child: Column(
                    children: [

                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width:  MediaQuery.of(context).size.width,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[



                                SizedBox(height: 60.0),

                                 Container(
                                  color: Colors.white70,
                                  child: Image.asset('images/logoCirc.png', width: 232, height: 170,),
                                ),

                                Text ('Crea tu cuenta', textAlign: TextAlign.center, style: globals.textStyleBienv,),
                                //SizedBox(height: 25.0),
                                //NickN,
                                SizedBox(height: 16.0),

                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: TextField(
                                      controller: Nombre,
                                      obscureText: false,
                                      style: globals.style,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                        hintText: NombreString,
                                        hintStyle: globals.HintStyle,
                                      )
                                  ),
                                ),

                                SizedBox(height: 16.0),

                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: TextField(
                                      controller: ApellidoP,
                                      obscureText: false,
                                      style: globals.style,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                        hintText: ApellidoPString,
                                        hintStyle: globals.HintStyle,
                                      )
                                  ),
                                ),

                                SizedBox(height: 16.0),

                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: TextField(
                                      controller: ApellidoM,
                                      obscureText: false,
                                      style: globals.style,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                        hintText: ApellidoMString,
                                        hintStyle: globals.HintStyle,
                                      )
                                  ),
                                ),

                                SizedBox(height: 16.0),

                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width*0.7,
                                  child: TextField(
                                    controller: Mail,
                                    obscureText: false,
                                    style: globals.style,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                      hintText: eMailString,
                                      hintStyle: globals.HintStyle,
                                      /*focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.0, color: globals.ColorMorado),
                                      )*/
                                    ),
                                  ),
                                ),
                                SizedBox(height: 16.0),

                                Container (
                                    height: 40,
                                    width:  MediaQuery.of(context).size.width*0.7,
                                    child: TextField(
                                        controller: Contrasena,
                                        obscureText: true,
                                        style: globals.style,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                          hintText: ContrString,
                                          hintStyle: globals.HintStyle,
                                          /*focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.0, color: globals.ColorMorado),
                                      )*/
                                        )
                                    )
                                ),

                                SizedBox(height: 16.0),

                                Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width*0.7,
                                    child: TextField(
                                        controller: ConfContrasena,
                                        obscureText: true,
                                        style: globals.style,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                          hintText: ConfContrString,
                                          hintStyle: globals.HintStyle,
                                          /*focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(width: 1.0, color: globals.ColorMorado),
                                      )*/
                                        )
                                    )
                                ),

                                SizedBox(height: 24.0),

                                Container(
                                  height: 40,
                                  width:  MediaQuery.of(context).size.width*0.7,
                                  child: Row(
                                      children: [
                                        Container(
                                          child: Checkbox(
                                            value: agree,
                                            onChanged: (value) {
                                              setState(() {
                                                agree = value;
                                              });
                                            },
                                          ),
                                        ),
                                        Text('Aceptar Términos',
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                ),

                                SizedBox(height: 24.0),

                                Container(
                                    height: 48.0,
                                    width:  MediaQuery.of(context).size.width*0.6,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        //shape: CircleBorder(),
                                        primary: Colors.blueAccent,
                                        //textStyle: TextStyle(color: Colors.white),
                                        elevation: 0.0,
                                      ),
                                      onPressed:(){

                                        if (ValidarDatos () == true)
                                        {
                                          if(agree){

                                            requestCrearUsuario(Nombre.text, ApellidoP.text, ApellidoM.text, Mail.text, Contrasena.text, ConfContrasena.text);

                                          }else{

                                            /*Fluttertoast.showToast(
                                                msg: "Favor de aceptar los Términos y Condiciones.",
                                                toastLength: Toast.LENGTH_LONG,
                                                gravity: ToastGravity.BOTTOM,
                                                timeInSecForIosWeb: 3,
                                                backgroundColor: globals.ColorMorado,
                                                textColor: Colors.white,
                                                fontSize: 10.0
                                            );*/

                                            CustomDialog.Show(context, "Favor de aceptar los Términos y Condiciones.", "warning");

                                          }



                                        }else{

                                          /*Fluttertoast.showToast(
                                              msg: "Favor de capturar todos los campos.",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: globals.ColorMorado,
                                              textColor: Colors.white,
                                              fontSize: 10.0
                                          );*/

                                          CustomDialog.Show(context, "Favor de capturar todos los campos.", "warning");
                                        }


                                      },
                                      child: const Text('Crear Cuenta', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                    )

                                ),

                                /*SizedBox(height: 20.0),
                                //Regfacebook,
                                //SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: (){
                                    Navigator.pushNamed(context, '/Login');
                                  },
                                  child: TextYaCuenta,
                                ),*/

                                SizedBox(height: 16.0),
                              ],
                            ),
                          ),
                        ),
                      ),


                      /*Container(
                    height: 17,
                    color: globals.ColorMorado,
                  ),*/

                    ],
                  ),



                )

            ),




            ///////////////////////////////////////////////////////////////////////////////
            /////////////////////////////////////////// Botones de menu
            SafeArea(
              top: true,
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    /*border: Border(
                      bottom: BorderSide(width: 1.0, color: Color(0xff979797)),
                    ),*/
                    color: Colors.transparent,
                ),
              ),
            ),


            SafeArea(
              top:true,
              child: Container(
                color: Colors.transparent,
                width: globals.screenw,
                height: 65,
                child: Row(
                  children: [

                    SizedBox(width: 5),

                    Container(
                      height: 65,
                      width: 63,
                      color: Colors.transparent,
                      child: Center(
                          child:  Material(
                            elevation: 5.0,
                            color: Color(0xff777777),
                            shape: CircleBorder(),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 20,
                                child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: (){

                                Navigator.pop(context);

                              },
                            ),

                          )

                      ),
                    ),

                    Container(
                      alignment: Alignment.topCenter,
                      width: globals.screenw-5-63-63-5,
                      //child: Text("perfil", style: TextStyle(fontFamily: 'Sarabun', fontSize: 35.0, color: globals.ColorGrisTexto),),
                    ),

                    Container(
                      width: 63,
                      color: Colors.transparent,
                      alignment: Alignment.topCenter,
                      child: Center(
                          child:  Material(
                            elevation: 5.0,
                            color: Color(0xff777777),
                            shape: CircleBorder(),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(15),
                              child: CircleAvatar(
                                backgroundColor: Colors.deepPurple,
                                radius: 20,
                                child: Icon(
                                  Icons.close,
                                  size: 25,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: (){

                              },
                            ),

                          )

                      ) ,
                    ),

                  ],
                ),

              ),
            ),


          ],
        ),





        //),

    );


  }

  bool ValidarDatos ()
  {
    bool DatosOK = true;

    ColorLineaExtMail = Colors.white;
    ColorFocusExtMail = globals.ColorAzulTema;
    ColorLineaExtNick = Colors.white;
    ColorFocusExtNick = globals.ColorAzulTema;
    ColorLineaExtContr = Colors.white;
    ColorFocusExtContr = globals.ColorAzulTema;
    ColorLineaExtConfContr = Colors.white;
    ColorFocusExtConfContr = globals.ColorAzulTema;


    /*if ((NickName.text.isEmpty) || (NickName.text.length < 1))
    {
      DatosOK = false;

      NickName.clear();
      ColorLineaExtNick = Colors.red;
      ColorFocusExtNick = Colors.red;
      NickString = "Falta nick";
      NickName.text = "";
    }*/

    /*else
      {

        Fluttertoast.showToast(
            msg: "Falta nickname",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 2,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }*/

    if (!Mail.text.isEmpty)
      {
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regex = new RegExp(pattern);

        if (!regex.hasMatch(Mail.text.trim()))
          {
            DatosOK = false;

            Mail.clear();
            ColorLineaExtMail = Colors.red;
            ColorFocusExtMail = Colors.red;
            eMailString = "email mal escrito";
            Mail.text = "";

          }
      }

    else
      {
        DatosOK = false;

        Mail.clear();
        ColorLineaExtMail = Colors.red;
        ColorFocusExtMail = Colors.red;
        eMailString = "Falta email";
        Mail.text = "";
      }

    if ((Contrasena.text.isEmpty) || (Contrasena.text.length < 6))
      {
        DatosOK = false;

        Contrasena.clear();
        ColorLineaExtContr = Colors.red;
        ColorFocusExtContr = Colors.red;
        ContrString = "Minimo 6 caracteres";
        Contrasena.text = "";

      }

    if ((ConfContrasena.text.isEmpty) || (ConfContrasena.text != Contrasena.text))
      {
        DatosOK = false;

        ConfContrasena.clear();
        ColorLineaExtConfContr = Colors.red;
        ColorFocusExtConfContr = Colors.red;
        ConfContrString = "No coinciden las contraseñas";
        ConfContrasena.text = "";
      }

    return DatosOK;
  }
}