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
      body: Stack(
        children: [

          SafeArea(
              top: true,
              bottom: true,
              child: Container(
                //width:  MediaQuery.of(context).size.width*0.9,
                child:
                Center(
                  child:  Container(
                    height: 500,
                    //width:  MediaQuery.of(context).size.width*0.8,
                    child: Column(
                      children: <Widget>[

                        SizedBox(height: 60,),

                        Expanded(
                          flex: 1,
                          child:Container(
                            width: globals.screenw*0.6,
                            child: Text ('Te hemos mandado un mail de confirmación. ', textAlign: TextAlign.center, style: globals.textStyleBienv,),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child:Container(
                            width: globals.screenw*0.6,
                            child: Text ('Necesitas confirmar para entrar a tu cuenta', textAlign: TextAlign.center, style: globals.textStyleBienv,),
                          ),
                        ),

                        Expanded(
                            flex: 2,
                            child: Container(
                                child: Center(
                                  child: Container(
                                      width: 296.0,
                                      height: 48.0,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blueAccent,
                                          elevation: 0.0,
                                        ),
                                        onPressed: () {

                                          Navigator.pushNamed(context, '/Login');

                                        },
                                        child: const Text('Entrar', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                      )
                                  ),
                                )


                            )


                        ),



                        Expanded(
                          flex: 2,
                          child:Container(
                            child: Image.asset('images/logo.png', width: 150,),
                          ),
                        ),


                      ],
                    ),


                  ),

                ),




              )

          ),

        ],

      ),

      //)
    );


  }
}


