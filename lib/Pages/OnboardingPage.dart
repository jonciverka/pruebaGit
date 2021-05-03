import 'package:flutter/material.dart';
import 'dart:async';
//import 'package:dynamic_theme/dynamic_theme.dart';
import '../globals.dart' as globals;
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardPage extends StatefulWidget {
  OnboardPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  OnboardPageState createState() => OnboardPageState();
}

class OnboardPageState extends State<OnboardPage> {

  final _controller = PageController();

  int _currentIndex = 0;

  final List<ExplanationData> data = [
    ExplanationData(
        description:
        "Has llegado a la comunidad para mamás y papás más importante en el mundo de habla hispana.",
        title: "¡Solo nos faltabas tú!",
        localImageSrc: "images/onb1.jpg",
        backgroundColor: Colors.white),
    ExplanationData(
        description:
        "Registra diariamente el camino hacia tu transformación como mamá o papá efectivo no perfecto.",
        title: "Resultados tangibles en la palma de tu mano",
        localImageSrc: "images/onb2.jpg",
        backgroundColor: Colors.white),
    ExplanationData(
        description:
        "Vive la crianza de una manera guiada y acompañada: como nunca antes la habías experimentado.",
        title: "Pon en práctica el Método Paternidad Efectiva®",
        localImageSrc: "images/onb3.jpg",
        backgroundColor: Colors.white),
  ];


  createCircle({int index}) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        margin: EdgeInsets.only(right: 4),
        height: 5,
        width: _currentIndex == index ? 15 : 5, // current indicator is wider
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(3)));
  }


  @override
  void initState() {
    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    return Container(
        color: data[_currentIndex].backgroundColor,
        child: SafeArea(
          top: true,
            child: Container(
              padding: EdgeInsets.all(16),
              color: data[_currentIndex].backgroundColor,
              alignment: Alignment.center,
              child: Column(children: [


                      Expanded(
                        flex: 6,
                        child: Container(
                            alignment: Alignment.center,
                            child: PageView(
                                scrollDirection: Axis.horizontal,
                                controller: _controller,
                                onPageChanged: (value) {
                                  // _painter.changeIndex(value);
                                  setState(() {
                                    _currentIndex = value;
                                  });
                                  // notifyListeners();
                                },
                                children: data.map((e) => ExplanationPage(data: e)).toList()
                            )
                        ),
                      ),
                      Expanded(
                          flex: 4,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(data.length,(index) => createCircle(index: index)),
                                )
                              ),

                              BottomButtons(
                                currentIndex: _currentIndex,
                                dataLength: data.length,
                                controller: _controller,
                              ),

                              SizedBox(
                                height: 20,
                              ),

                              Container(
                                //color: Colors.grey,
                                child: Column(
                                  children: [

                                    Container(
                                      width: 200,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          //shape: CircleBorder(),
                                          primary: Colors.pinkAccent,
                                          //textStyle: TextStyle(color: Colors.white),
                                          elevation: 0.0,
                                        ),
                                        onPressed: () {

                                          Navigator.pushNamed(context, '/Registro');

                                        },
                                        child: const Text('Quiero registrarme', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                      ),

                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),

                                    Container(
                                      width: 200,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            //shape: CircleBorder(),
                                            primary: Colors.greenAccent,
                                            //textStyle: TextStyle(color: Colors.white),
                                            elevation: 0.0,
                                          ),
                                          onPressed: () {

                                            Navigator.pushNamed(context, '/Login');

                                          },
                                          child: const Text('Iniciar sesión', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                                        )
                                    )

                                  ],
                                ),

                              )
                              /*BottomButtons(
                                currentIndex: _currentIndex,
                                dataLength: data.length,
                                controller: _controller,
                              )*/
                            ],
                          ))


              ]),
            )
        )
    );




  }

}

class ExplanationData {
  final String title;
  final String description;
  final String localImageSrc;
  final Color backgroundColor;

  ExplanationData({this.title, this.description, this.localImageSrc, this.backgroundColor});
}

class ExplanationPage extends StatelessWidget {
  final ExplanationData data;

  ExplanationPage({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        Container(
            margin: EdgeInsets.only(top: 0, bottom: 0),
            child: Image.asset(data.localImageSrc, height: MediaQuery.of(context).size.height * 0.33,)
        ),/*SvgPicture.asset(data.localImageSrc,
                height: MediaQuery.of(context).size.height * 0.33,
                alignment: Alignment.center)),*/
        Expanded(
          child: Text(
                  data.title,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),

        ),
        Expanded(
          child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 48),
                  child: Text(
                    data.description,
                    style: Theme.of(context).textTheme.bodyText2,
                    textAlign: TextAlign.center,
                  )
          )


        ),
      ],
    );
  }
}

class BottomButtons extends StatelessWidget {
  final int currentIndex;
  final int dataLength;
  final PageController controller;

  const BottomButtons(
      {Key key, this.currentIndex, this.dataLength, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:[

            Visibility(
              visible: currentIndex > 0,
              child: TextButton(
              //minWidth: 0.0,
                onPressed: () {
                  controller.previousPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut
                  );

                },
                child: Container(
                alignment: Alignment.center,
                child: Icon(
                Icons.arrow_back,
                color: Colors.black,
                )
                )
              ),

            ),

            Visibility(
              visible: currentIndex < dataLength - 1,
              child: TextButton(
                //padding: EdgeInsets.zero,
                //minWidth: 0.0,
                onPressed: () {
                  controller.nextPage(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut
                  );
                },
                child: Container(
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    )


                ),

              )

            )


          ],


        );
  }
}

