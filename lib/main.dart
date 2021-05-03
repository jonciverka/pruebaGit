import 'package:flutter/material.dart';
import 'package:ninosdeahora/Pages/PrincipalPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Pages/OnboardingPage.dart';
import 'Pages/RegistroPage.dart';
import 'Pages/LoginPage.dart';
import 'Pages/ClaveOlvidadaPage.dart';
import 'Pages/WelcomePage.dart';
import 'Pages/ConfirmMailPage.dart';
import 'Pages/SeccionesCursoPage.dart';

import 'globals.dart' as globals;

/*void main() {
  runApp(MyApp());
}*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Uncomment this to use the auth emulator for testing
  // await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        title: 'Niños de Ahora',
        //theme: theme,
        home: SplashScreen(),
        routes: {
          '/home': (context) => MyHomePage(),
          '/homepage': (context) => PrincipalPage(),
          '/seccionesCursos': (context) => SeccionesCurso(),
          '/Onboard': (context) => OnboardPage(),
          '/Login': (context) => LoginPage(),
          '/RecuperarClave': (context) => RecuperarClave(),
          '/Registro': (context) => Registro(),
          '/Welcome': (context) => WelcomePage(),
          '/Confirmail': (context) => ConfirmMailPage(),
        },

    );
  }
}

////////////////////////  Splash //////////////////////
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Espera 2 segundos y abre home page
    Future.delayed(Duration(seconds: 3), (){

      _logeado();

    });

  }


  _logeado()async{


    SharedPreferences prefs = await SharedPreferences.getInstance();
    String access_token = (prefs.getString('access_token') ?? "");

    User user = FirebaseAuth.instance.currentUser;

    print(".......logueado FB ini");

    if (user == null) {
      Navigator.pushNamed(context, '/Onboard');
    } else {

      globals.access_token = access_token;

      if (user.emailVerified) {
        Navigator.pushNamed(context, '/homepage');
      }else{
        Navigator.pushNamed(context, '/Confirmail');
      }


    }

    /*FirebaseAuth.instance.authStateChanges().listen((User user) {

      print(".......logueado FB ini");

      if (user == null) {
        Navigator.pushNamed(context, '/Onboard');
      } else {

        globals.access_token = access_token;

        if (user.emailVerified) {
          Navigator.pushNamed(context, '/homepage');
        }else{
          Navigator.pushNamed(context, '/Confirmail');
        }

      }
    });*/


  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    globals.screenh = MediaQuery.of(context).size.height;
    globals.screenw = MediaQuery.of(context).size.width;
    globals.appBarHeight = 48;//AppBar().preferredSize.height;
    globals.safeHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;

    globals.bodyHeight = globals.safeHeight - globals.appBarHeight;

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.all(0),
      child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width*0.7,
            child: Image.asset('images/logo.png', width: 100, height: 100, fit: BoxFit.contain,)
        )
      ),
    );


  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(

          child: Text(
            'Espera',
          ),
        )



      ),

    );
  }
}
