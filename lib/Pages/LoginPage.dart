import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninosdeahora/Provider/login_provider.dart';
import 'package:ninosdeahora/Modelos/LoginMod.dart';
import 'package:ninosdeahora/Widgets/DialogCustom.dart';



////////////////////    Pagina principal    ///////////////////////////////////////
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {

  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();

  OverlayEntry WaitingScreen = globals.createWaitCirculo();


  @override
  void initState() {
    super.initState();

  }

  requestLogin(String email, String password) async {


    try {

      Overlay.of(context).insert(WaitingScreen);

      //FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) async{
      final auth = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      print(".......logueado FB");

          final User user = auth.user;//loginfb.user;


          if (user != null)
          {

            if (!user.emailVerified) {
              await FirebaseAuth.instance.signOut();
              WaitingScreen.remove();
              Navigator.pushNamed(context, '/Confirmail');
            }else{

              print("....................logeado firebase");

              final idToken = await user.getIdToken();


              Login valor = await LoginProvider().loginServer(idToken, user.uid);

              print(".................Token: ${valor.token}");

              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setString('access_token', valor.token);

              WaitingScreen.remove();

              /*Fluttertoast.showToast(
                  msg: "Logueado",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.blue,
                  textColor: Colors.white,
                  fontSize: 15.0
              );*/

              globals.nombreusuario = valor.nombre;

              Future.delayed(Duration(seconds: 1), () {
                print("........................entrando a home");
                Navigator.pushNamed(context, '/homepage');
              });
            }
          }




      /*}).timeout(Duration(seconds: 10),
        onTimeout: () {

          print(".... No hay respuesta de FB");

          WaitingScreen.remove();

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
      );*/





    } catch (e) {

      WaitingScreen.remove();

      CustomDialog.Show(context, "Email o contraseña incorrecta, favor de verificar.", "warning");

        /*Fluttertoast.showToast(
            msg: "Email o contraseña incorrecta, favor de verificar.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 10.0
        );*/
    }


  }


@override
  Widget build(BuildContext context) {


    return /*Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: globals.gradienteback,
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
                        child:Container(
                          //width:  MediaQuery.of(context).size.width*0.9,
                          child: Column(
                              children: [

                                Center(
                                  child:  Container(
                                    height: MediaQuery.of(context).size.height,
                                    //width:  MediaQuery.of(context).size.width*0.8,
                                    child: SingleChildScrollView(
                                      child: Container(
                                        width: 296,
                                        child: Column(
                                          children: <Widget>[

                                            SizedBox(height: 60.0),
                                            Image.asset('images/logoCirc.png', width: 232, height: 170,),
                                            SizedBox(height: 5.0),
                                            Text ('¡Hola de nuevo!', textAlign: TextAlign.center, style: globals.textStyleBienv,),
                                            SizedBox(height: 10.0),
                                            Text ('Iniciar sesión', textAlign: TextAlign.center, style: globals.textStyleBienv,),
                                            SizedBox(height: 30.0),
                                            Container (
                                                height: 40,
                                                child: TextField(
                                                    maxLines: 1,
                                                    controller: emailcontroller,
                                                    obscureText: false,
                                                    style: globals.style,
                                                    keyboardType: TextInputType.emailAddress,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                      hintText: "Email",
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
                                                child:TextField(
                                                    controller: passcontroller,
                                                    obscureText: true,
                                                    style: globals.style,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                                      hintText: "Contraseña",
                                                      hintStyle: globals.HintStyle,
                                                      /*focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(width: 1.0, color: globals.ColorMorado),
                                                      )*/
                                                    )
                                                )
                                            ),
                                            SizedBox(height: 21.0),
                                            GestureDetector(
                                              onTap: (){
                                                //VerRecuperarClave(context);
                                                Navigator.pushNamed(context, '/RecuperarClave');
                                              },
                                              child: Text ('¿Olvidaste tu contraseña?', textAlign: TextAlign.center, style: TextStyle(color: Colors.black54, fontSize: 15.0)),
                                            ),
                                            SizedBox(height: 40.0),
                                            Container(
                                                width: 296.0,
                                                height: 48.0,
                                                child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    //shape: CircleBorder(),
                                                    primary: Colors.blueAccent,
                                                    //textStyle: TextStyle(color: Colors.white),
                                                    elevation: 0.0,
                                                  ),
                                                  onPressed: () {

                                                    if ( !emailcontroller.text.isEmpty && !passcontroller.text.isEmpty)
                                                    {
                                                      requestLogin(emailcontroller.text, passcontroller.text);
                                                    }
                                                    else
                                                    {

                                                      Fluttertoast.showToast(
                                                          msg: "Llena los campos",
                                                          toastLength: Toast.LENGTH_SHORT,
                                                          gravity: ToastGravity.BOTTOM,
                                                          timeInSecForIosWeb: 2,
                                                          backgroundColor: globals.ColorMorado,
                                                          textColor: Colors.white,
                                                          fontSize: 16.0
                                                      );
                                                    }
                                                  },
                                                  child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                                )

                                            ),
                                            SizedBox(height: 24.0),
                                            Image.asset('images/logo.png', width: 100, height: 100,),
                                            SizedBox(height: 30.0),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),

                                ),

                                /*Container(
                                  height: 17,
                                  color: globals.ColorMorado,
                                ),*/

                              ]),
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

                            ),

                          ],
                        ),

                      ),
                    ),

                  ],

                ),



              //)
    );


  }
}




