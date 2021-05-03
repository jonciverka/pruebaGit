import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';


////////////////////    Pagina principal    ///////////////////////////////////////
class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {



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
                          height: 400,
                          //width:  MediaQuery.of(context).size.width*0.8,
                          child: Column(
                            children: <Widget>[

                              SizedBox(height: 60,),

                              Expanded(
                                flex: 1,
                                child:Container(
                                  child: Text ('¡Hola de nuevo!', textAlign: TextAlign.center, style: globals.textStyleBienv,),
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

                                              Navigator.pushNamed(context, '/Perfil');

                                            },
                                            child: const Text('¡Si quiero!', style: TextStyle(color: Colors.white, fontSize: 18.0)),
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


