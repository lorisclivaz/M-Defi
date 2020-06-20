import 'package:flutter/material.dart';
import 'package:mdefi/screens/LogicQuestion/optionOne.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:nice_button/NiceButton.dart';

class endQuiz extends StatelessWidget {


  //Variable du score et du nombre de pages
  int score;
  int pointPositif;
  int pointNegatif;
  int nbrPage;
  String nomQuiz;
  String petitePhrase = '';


  //Constructeur
  endQuiz(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage,this.petitePhrase);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BackGroundImage.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[400],
              title: Text("Score"),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () =>
                      print('Annulation du quiz')
                  ,
                ),
              ],
              leading: new Container(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                        child: NiceButton(
                          elevation: 10.0,
                          radius: 52.0,
                          width: MediaQuery.of(context).size.width*0.80,
                          text: '$nomQuiz',
                          background: Colors.blue.withOpacity(0.2),
                          fontSize: 20,
                        )
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                        child:NiceButton(
                          elevation: 10.0,
                          radius: 52.0,
                          width: MediaQuery.of(context).size.width*0.80,
                          text: 'Points positif :  $pointPositif',
                          background: Colors.blue.withOpacity(0.2),
                          fontSize: 20,
                        )
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                        child:NiceButton(
                          elevation: 10.0,
                          radius: 52.0,
                          width: MediaQuery.of(context).size.width*0.80,
                          text: 'Points négatif :  $pointNegatif',
                          background: Colors.blue.withOpacity(0.2),
                          fontSize: 20,
                        )
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                        child:NiceButton(
                          elevation: 10.0,
                          radius: 52.0,
                          width: MediaQuery.of(context).size.width*0.80,
                          text: 'Total des points :  $score',
                          background: Colors.blue.withOpacity(0.2),
                          fontSize: 20,
                        )
                    ),
                  ),

                  Text(''),
                  NiceButton(
                    elevation: 10.0,
                    radius: 52.0,
                    width: MediaQuery.of(context).size.width*0.80,
                    text: "$petitePhrase",
                    background: Colors.white30,
                    fontSize: 20,
                  ),
                  Text(''),
                  NiceButton(
                    elevation: 10.0,
                    radius: 52.0,
                    width: MediaQuery.of(context).size.width*0.80,
                    text: "Page d'accueil",
                    background: Colors.white70,
                    fontSize: 20,
                    onPressed:(){


                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          HomeApp()), (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
