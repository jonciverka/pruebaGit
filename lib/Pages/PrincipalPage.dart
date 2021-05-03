
import 'package:flutter/material.dart';
import 'package:ninosdeahora/Pages/InicioPage.dart';


class PrincipalPage extends StatefulWidget {  

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}


class _PrincipalPageState extends State<PrincipalPage> {
  int currentIndex = 1;
 
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          extendBody: true,      
          body: _callPage(currentIndex),
          bottomNavigationBar: _bottomNavigator(context),
      ),
    );
    
  }

  Widget _callPage(int paginActual){
    switch(paginActual){
      case 0 : return InicioPage(); 
      default: return InicioPage();
    }
  }


  
  Widget _bottomNavigator(BuildContext context){
    return  BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Diario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Pefil',
          ),
        ],
        currentIndex: currentIndex,
        selectedItemColor: Colors.amber[800],
        onTap: (index){
            setState(() {
              currentIndex = index;
            });
        },
      );
  }

  
  
}