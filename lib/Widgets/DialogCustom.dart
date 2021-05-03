import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDialog{

  static Future<bool> Show(dynamic context, String mensaje, String tipo)async{

    Dialog errorDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
      child: WidgetDialog(mensaje, tipo),
    );
    showDialog(context: context, builder: (BuildContext context) => errorDialog);

  }

}

class WidgetDialog extends StatelessWidget {

  WidgetDialog(this.mensaje, this.tipo);

  String mensaje;
  String tipo;

  Icon icono;

  @override
  Widget build(BuildContext context) {

    if(tipo == "warning"){
      icono = Icon(Icons.warning_outlined, size: 50, color: Colors.deepOrangeAccent,);
    }else if(tipo == "success"){
      icono = Icon(Icons.check, size: 50, color: Colors.green,);

    }

    return Container(
      height: 230.0,
      width: 200.0,

      child: Center(
        child: Container(
          height: 230.0,
          width: 190.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              icono,

              Padding(
                padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child: Text(mensaje, textAlign: TextAlign.center, style: TextStyle(color: Colors.black54),),
              ),
              Padding(padding: EdgeInsets.only(top: 10.0)),
              Container(
                  width: 100.0,
                  height: 30.0,
                  child:
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      //shape: CircleBorder(),
                      primary: Colors.blueAccent,
                      elevation: 0.0,
                    ),
                    onPressed: () {

                      Navigator.of(context).pop();

                    },
                    child: const Text('Ok', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  )
              )

            ],
          ),
        ),
      ),


    );
  }
}

