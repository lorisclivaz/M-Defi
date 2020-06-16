/*
 * Author : Loris Clivaz
 * Date creation : 14 juin 2020
 */

import 'package:flutter/material.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer le score à la fin du quiz
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class QuizEnd extends StatefulWidget {

  //Variable du score et du nombre de pages
  int score;
  int pointPositif;
  int pointNegatif;
  int nbrPage;
  String nomQuiz;

  //Constructeur
  QuizEnd(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage);

  @override
  _QuizEndState createState() => _QuizEndState();
}

class _QuizEndState extends State<QuizEnd> {

  //Variable loading;
  bool loading = false;

  //Variables quiz
  int score = 0;
  int pointPositif = 0;
  int pointNegatif = 0;
  int nbrPage = 0;
  String nomQuiz = '';

  //Méthode de récupération des valeurs finales du quiz
  @override
  void initState() {
    super.initState();
    loading = true;

    if(loading == true)
      {
        nomQuiz = widget.nomQuiz;
        score = widget.score;
        pointPositif = widget.pointPositif;
        pointNegatif = widget.pointNegatif;
        nbrPage = widget.nbrPage;
        loading = false;
        score = widget.pointPositif + widget.pointNegatif;
      }

  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : MaterialApp(
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
                    text: "Page d'accueil",
                    background: Colors.white70,
                    fontSize: 20,
                    onPressed:(){

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => HomeApp(),
                      ));
                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
