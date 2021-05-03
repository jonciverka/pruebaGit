
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ninosdeahora/Provider/cursos_provider.dart';

class SeccionesCurso extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SeccionesCursoState();    
  }
}

class _SeccionesCursoState extends State<SeccionesCurso> {
  final cursoProvider = new CursosProvider();
  var _pkCurso = 0;
  var nombreCurso = '';
  Future _apartados ;  
   @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>  asyncInitState());
  }
  void asyncInitState() async {
    setState(() {
      Map args = ModalRoute.of(context).settings.arguments; 
      _pkCurso = args["pkCurso"];
      nombreCurso = args["nombreCurso"];
      _apartados = cursoProvider.obtenerApartadosCurso(_pkCurso);       
     
    });
  }
  @override
  Widget build(BuildContext context) {    
    return  Scaffold(
      backgroundColor: Color(0xffeeede9),
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _apartadosWdgt()
          ],
        ),
      )
    );      
  }
  Widget _header(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Text(nombreCurso, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
      ),
    );
  }
  Widget _apartadosWdgt(){
    final _screenSize = MediaQuery.of(context).size;
    return  FutureBuilder(
      future: _apartados ,
      builder: (BuildContext context, AsyncSnapshot snapshot) {   
        if(snapshot.hasData){            
          List<dynamic> loaded = snapshot.data;  
          return 
            Container(
              width: double.infinity,
              height: _screenSize.height - 170,
              child:  GridView.builder(                        
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio:  MediaQuery.of(context).size.width /(MediaQuery.of(context).size.height /1.5),
                ),
                itemCount: loaded.length,
                itemBuilder: (context, i){
                  return  Container(
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        height: 150,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FadeInImage(
                            image: NetworkImage(snapshot.data[i].url),            
                            placeholder: AssetImage('images/logoCirc.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                },                        
              )
            );
        }else
          return CircularProgressIndicator();   
      }
    );
  }


}