/*
 * Author : Loris Clivaz
 * Date creation : 14 juin 2020
 */

import 'package:flutter/material.dart';

/*
 * Classe qui va gérer le score à la fin du quiz
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class QuizEnd extends StatefulWidget {

  //Variable du score et du nombre de pages
  int score;
  int nbrPage;

  //Constructeur
  QuizEnd(this.score, this.nbrPage);

  @override
  _QuizEndState createState() => _QuizEndState();
}

class _QuizEndState extends State<QuizEnd> {

  //Design de la page
  @override
  Widget build(BuildContext context) {
    print(widget.score);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
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
          ),
        )
    );
  }
}
