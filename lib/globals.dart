library my_prj.globals;

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

double screenw = 0;
double screenh = 0;
double safeHeight = 0;
double appBarHeight = 0;
double bodyHeight = 0;

const ColorMorado = Color(0xFF46185A);
const ColorNaranja = Color(0xFFF05A29);
const ColorNaranja2 = Color(0xFFEF8031);
const ColorAzulTema = Color(0xFF44A3CF);
const ColorFondo = Color(0xffA2ACBD);
const ColorAzulClaro = Color(0xFFF5F9FF);
const ColorGrisBarra = Color(0xFFF4F4F4);
const ColorFondGris = Color(0xFFF4F4F4);
const ColorBotonAzul = Color(0xFF44A3CF);
const ColorBotonFB = Color(0xFF425BB4);
const ColorBotonGris = Color(0xFFA1A1A1);

//const gradienteback = [Color(0xFFE7E7E7), Color(0xFF676464)];
//const gradienteback = [Color(0xFFF5F9FF), Color(0xFFD5D5D5), Color(0xFFCFD0CE), Color(0xFFCACBC9), Color(0xFFBCBDBB), Color(0xFFA5A5A4), Color(0xFF848483), Color(0xFF5A5A59), Color(0xFF676464)];
const gradienteback = [Color(0xFFFFFFFF), Color(0xFFE0f0ff)];

String baseurl = "ninosdeahora.online";

TextStyle style = TextStyle(fontFamily: 'Roboto', fontSize: 20.0);
TextStyle style2 = TextStyle(fontFamily: 'Roboto', fontSize: 14.0, color: Color(0xFF315F79));
TextStyle textStyleBienv = TextStyle(fontFamily: 'Roboto', fontSize: 20.0, color: Color(0xFF777777));
TextStyle HintStyle = TextStyle(fontFamily: 'Roboto', fontSize: 15.0, color: Color(0xFF323233));
TextStyle CamCortoStyle = TextStyle(fontFamily: 'Roboto', fontSize: 18.0, color: Colors.lightBlueAccent);
TextStyle HoyQuiero = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 35.0, color: ColorAzulTema);
TextStyle TituloLista = TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black);
TextStyle NombreLista = TextStyle(fontFamily: 'Roboto', fontSize: 14.0, color: Colors.black);
TextStyle PerfilBuscar = TextStyle(fontFamily: 'Roboto', fontSize: 18.0, color: Color(0xFFFFFFFF));

///// Resgistro
bool isLoggedIn = false;
bool visRegistroComp = true;
bool VerContenido = false;
String access_token = '';
String fireabse_token = "";
double MenuHeight = 55;
String distancia = "0.15";
//Datos de usuario
int idusuario = 0;
String nombreusuario = '';
String emailusuario = '';
int  verificadousuario = 0;
String avatarurl = '';
int tipousuario = 0;
int iconousuario = 0;

/// Header de request
Map<String, String> headers = {
  "Accept": "application/json",
  "Content-Type": "application/json",
  "Authorization": "Bearer ${access_token}",
};

OverlayEntry createWaitCirculo() {

  return OverlayEntry(
      builder: (context) => Positioned(
          left: 0,
          top: 0,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Container(
            color: Colors.transparent.withOpacity(0.5),
            child: Center(
                child: Container(
                    height: 50,
                    width: 50,
                    child:  CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                )
            ),
          )
      )
  );
}