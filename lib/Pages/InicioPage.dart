import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ninosdeahora/Provider/cursos_provider.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../globals.dart' as globals;

class InicioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InicioPageState();    
  }
}
class _InicioPageState extends State<InicioPage> {
  final cursoProvider   =  new CursosProvider();
  Future _cursos ;  

  @override
  void initState() {
    super.initState();  
     WidgetsBinding.instance.addPostFrameCallback((_) => {
      asyncInitState()
    });
  }
   void asyncInitState() async {
     setState(() {
      _cursos = cursoProvider.obtenerCursos();       
     });
  }

  @override
  Widget build(BuildContext context) {    
    return  Scaffold(        
      backgroundColor: Color(0xffeeede9),
      body: SafeArea(
          child: Column(
          children: [
            _prueba(),
            _prueba1(),
            _centroNotificaciones(),
            _entrenamientos(),
            _otros(),
          ],
        ),
      )
    );      
  }
  Widget _prueba(){
    return Container(child: Text("hola22222"),);
  }
   Widget _prueba1(){
    return Container();
  }
  Widget _centroNotificaciones(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,),
      padding: EdgeInsets.symmetric(vertical: 10,),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notification_important),
          Text("No cuentas con ninguna notificacion")
        ],
      ),
    );
  }
  Widget _entrenamientos(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text("Mis entrenamientos", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
          FutureBuilder(
          future: _cursos,
          builder: (BuildContext context, AsyncSnapshot snapshot) { 
            if(snapshot.hasData){
                return Table(
                  children: [
                    TableRow(
                      children: [
                        GestureDetector(
                          onTap: ()=>Navigator.pushNamed(context, '/seccionesCursos',arguments: {"pkCurso": snapshot.data[0].pkCurso, "nombreCurso":snapshot.data[0].nombre}),
                          child: Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)
                            ),
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: FadeInImage(
                                image: NetworkImage(snapshot.data[0].url),            
                                placeholder: AssetImage('images/logoCirc.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          height: 150,
                        )
                      ]
                    )
                  ],
                );
            }else
              return CircularProgressIndicator();     
            }
          )
        ],
      ),
    );
  }
  Widget _otros(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: 
        Table(
          children: [
            TableRow(
              children: [
                Column(
                  children: [
                    Text("Mi transformación", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      height: 150,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Mis eventos", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Icon(Icons.calendar_today_outlined,size: 150,),
                      height: 150,
                    ),
                  ],
                ),
              ]
            )
          ],
        )
    );
  }
}