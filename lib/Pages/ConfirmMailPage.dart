import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';


////////////////////    Pagina principal    ///////////////////////////////////////
class ConfirmMailPage extends StatefulWidget {
  ConfirmMailPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ConfirmMailPageState createState() => ConfirmMailPageState();
}

class ConfirmMailPageState extends State<ConfirmMailPage> {



  @override
  void initState() {
    super.initState();

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
      body:  Container()
    
    );


  }
}


