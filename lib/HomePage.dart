import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';

/*import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:latlong/latlong.dart' as Latlong;
import 'package:http/http.dart';
import 'dart:convert';
import 'GinBox.dart';
import 'package:video_player/video_player.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as places;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:after_layout/after_layout.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';*/


////////////////////    Pagina principal    ///////////////////////////////////////
class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  final List MisCursos = [{"curso": "Ingles", "imagen": "images/USA.png", "comprado": 0},
                      {"curso": "Español", "imagen": "images/Mexico.png", "comprado": 1},
                      {"curso": "Japones", "imagen": "images/Japon.png", "comprado": 1},
                      {"curso": "Portugues", "imagen": "images/Brasil.png", "comprado": 0}];


  @override
  void initState() {
    super.initState();


  }

  statuscolor()async{

    //await FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    //await FlutterStatusbarcolor.setStatusBarWhiteForeground(false);

  }

  @override
  void afterFirstLayout(BuildContext context) {



  }



  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: scaffoldKey,
      drawer: MenuLateral(this),
      body: Stack(
      children: <Widget>[


        SafeArea(
          top: true,
            bottom: true,

            child: Column(

              children: [

                SizedBox(
                  height: 48,
                ),

                Container(
                  height: 60,
                  child: Center(child: Text("Mis cursos", style:  TextStyle(fontFamily: 'Roboto', fontSize: 35.0, color: Colors.orange))),
                ),

                Expanded(
                  child: Container(
                      width: globals.screenw,
                      color: Colors.white,
                      child: Center(
                        child: Container(
                          width: globals.screenw*0.95,
                          child: ListView.builder(
                            // Deja que ListView sepa cuántos elementos necesita para construir
                            itemCount: MisCursos.length,
                            // Proporciona una función de constructor. ¡Aquí es donde sucede la magia! Vamos a
                            // convertir cada elemento en un Widget basado en el tipo de elemento que es.
                            itemBuilder: (context, index) {

                              //final item = MisCursos[index];

                              return Card(
                                  child: Container(
                                    height: 60,
                                    width: globals.screenw*0.5,
                                    color: Colors.grey,
                                    child: Row(
                                        children: [

                                          Expanded(

                                            child: GestureDetector(
                                              onTap: (){


                                                print("... index ${index}");

                                                if(MisCursos[index]['comprado'] == 1){

                                                  Fluttertoast.showToast(
                                                      msg: "Abrir curso",
                                                      toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: globals.ColorMorado,
                                                      textColor: Colors.white,
                                                      fontSize: 10.0
                                                  );

                                                }else{

                                                  Fluttertoast.showToast(
                                                      msg: "Comprar",
                                                      toastLength: Toast.LENGTH_LONG,
                                                      gravity: ToastGravity.BOTTOM,
                                                      timeInSecForIosWeb: 3,
                                                      backgroundColor: globals.ColorMorado,
                                                      textColor: Colors.white,
                                                      fontSize: 10.0
                                                  );


                                                }



                                              },
                                              child: Container(

                                                  height: 60,
                                                  color: Colors.white,
                                                  child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: <Widget>[


                                                        SizedBox(width: 10.0),
                                                        Container (
                                                          child: CircleAvatar(
                                                            radius: 20,
                                                            backgroundImage: Image.asset(MisCursos[index]['imagen']).image,
                                                          ),
                                                        ),
                                                        SizedBox(width: 15.0),
                                                        Expanded(
                                                          child: Container(
                                                            child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                mainAxisSize: MainAxisSize.min,
                                                                children: <Widget>[
                                                                  Text(MisCursos[index]['curso'], textAlign: TextAlign.start, style: globals.textStyleBienv, maxLines: 1, overflow: TextOverflow.ellipsis),

                                                                  MisCursos[index]['comprado'] == 1 ?
                                                                  Text("Comprado", textAlign: TextAlign.start, style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0, color: Colors.blue), maxLines: 1, overflow: TextOverflow.ellipsis):
                                                                  Text("Comprar", textAlign: TextAlign.start, style: TextStyle(fontFamily: 'Roboto', fontSize: 14.0, color: Colors.green), maxLines: 1, overflow: TextOverflow.ellipsis)
                                                                ]
                                                            ),
                                                          ),
                                                        ),

                                                      ]
                                                  )
                                              ),
                                            ),

                                          ),


                                          GestureDetector(
                                            onTap: (){


                                              Fluttertoast.showToast(
                                                  msg: "Opciones",
                                                  toastLength: Toast.LENGTH_LONG,
                                                  gravity: ToastGravity.BOTTOM,
                                                  timeInSecForIosWeb: 3,
                                                  backgroundColor: globals.ColorMorado,
                                                  textColor: Colors.white,
                                                  fontSize: 10.0
                                              );


                                            },
                                            child: Container(
                                              height: 60,
                                              width: 60,
                                              color: Colors.white,
                                              child: Icon(Icons.workspaces_filled),
                                            ),

                                          ),

                                        ]

                                    ),

                                  )


                              );

                            },
                          ),

                        ),





                      )

                  ),
                ),



              ],
            )







        ),




        ///////////////////////////////////////////////////////////////////////////////
        /////////////////////////////////////////// Botones de menu
        SafeArea(
          top: true,
          child: Container(
            height: 48,
            decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Color(0xff979797)),
                ),
                color: Colors.white
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

                SizedBox(width: 15),

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
                            backgroundColor: Colors.blue,
                            radius: 28,
                            child: Icon(
                              Icons.view_headline,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                          onTap: (){

                            if(scaffoldKey.currentState.isDrawerOpen){
                              scaffoldKey.currentState.openEndDrawer();
                            }else{
                              scaffoldKey.currentState.openDrawer();
                            }

                          },
                        ),

                      )

                  ),
                ),

                Container(
                  alignment: Alignment.topCenter,
                  width: globals.screenw-15-70-80,
                  //child: Text("perfil", style: TextStyle(fontFamily: 'Sarabun', fontSize: 35.0, color: globals.ColorGrisTexto),),
                ),

                Container(
                  width: 70,
                  alignment: Alignment.topCenter,
                  //child: Center(
                      //child: Icon(Icons.view_headline, size: 40,)) ,
                ),

              ],
            ),

          ),
        ),





      ])





    );

  }
}


///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
///////////////////////////////////////////////////   Menu lateral  /////////////////////////////////////////////
class MenuLateral extends StatelessWidget{

  HomePageState parent;

  MenuLateral(this.parent);

  /*_navigateAdmin(BuildContext context) async {

    final result = await Navigator.pushNamed(context, '/admin');

    if (result != null ) {
      parent.setState(() {
      });
    }
  }*/

  _Salir(BuildContext context)async{

    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //await prefs.setString('access_token', "");
    /*await prefs.setString('idusuario', "0");
    await prefs.setString('nombreusuario', "");
    await prefs.setString('emailusuario', "");
    await prefs.setString('verificadousuario', "0");
    await prefs.setString('avatarurl', "");
    await prefs.setString('tipousuario', "0");
    await prefs.setString('iconousuario', "0");
    await prefs.setString('firebase_token', "");*/

    /*globals.idusuario =  0;
    globals.nombreusuario =  "";
    globals.emailusuario =  "";
    globals.verificadousuario =  0;
    globals.avatarurl =  "";
    globals.tipousuario =  0;
    globals.iconousuario =  0;
    globals.access_token = "";*/

    await FirebaseAuth.instance.signOut();

    Navigator.pushNamed(context, '/');


  }


  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 173.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue.withOpacity(0.5),
            child: Center(
              child: Container(
                width: 150,
                child: Image.asset('images/logo.png'),
              ),
            ),
          ),

          /*
          nformación personal
          Mis cursos
          Cursos y capacitaciones
          Notificaciones
          Historial
          Contacto
          Ayuda
           */

          ListTile(
            leading: Icon(Icons.supervised_user_circle, size: 35, color: Colors.deepPurple),
            title: Text('Información personal', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();


            },
          ),

          ListTile(
            leading: Icon(Icons.list, size: 35, color: Colors.deepPurple,),
            title: Text('Mis cursos', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          ListTile(
            leading: Icon(Icons.list_alt, size: 35, color: Colors.deepPurple),
            title: Text('Cursos y capacitaciones', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          ListTile(
            leading: Icon(Icons.notifications_active, size: 35, color: Colors.deepPurple),
            title: Text('Notificaciones', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          ListTile(
            leading: Icon(Icons.history_edu_sharp, size: 35, color: Colors.deepPurple),
            title: Text('Historial', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          ListTile(
            leading: Icon(Icons.contact_mail_outlined, size: 35, color: Colors.deepPurple),
            title: Text('Contacto', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          ListTile(
            leading: Icon(Icons.help, size: 35, color: Colors.deepPurple),
            title: Text('Ayuda', style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 15.0)),
            dense: true,
            //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
            onTap: (){
              Navigator.of(context).pop();
              //informacion.VerInformacion (context, parent);
              //Navigator.pushNamed(context, '/informacion');
            },
          ),

          Expanded (
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.exit_to_app, size: 35, color: Colors.blue,),
                title: Text("Salir", style: TextStyle(fontFamily: 'Roboto', color: Colors.black, fontSize: 18.0)),
                dense: true,
                //contentPadding: EdgeInsets.only(left: 15, top:0, bottom: 0),
                onTap: (){
                  Navigator.of(context).pop();
                  _Salir(context);
                },
              ),
            ),
          ),

        ],
      ) ,
    );
  }
}









