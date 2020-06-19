/*
 * Author : Loris Clivaz
 * Date creation : 14 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/screens/LogicQuestion/optionOne.dart';
import 'package:mdefi/screens/LogicQuestion/optionTwo.dart';
import 'package:mdefi/services/auth.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer les paramètres du quiz
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class QuestionPage extends StatefulWidget {

  //Variables quiz
  final String idQuiz;
  final String nameQuiz;

  //Constructeur
  const QuestionPage(this.idQuiz, this.nameQuiz);


  @override
  _QuestionPage createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {

  //Variable de la base de données
  final fb = FirebaseDatabase.instance.reference().child("question");

  //Variable paramètre des questions
  String level = '';

  //Variable question correct +2 incorrect -1
  int score = 0;
  int pointPositif = 0;
  int pointNegatif = 0;

  //Variable nombre de question du quiz
  int nbrPage = 0;
  String nomquiz = '';
  int choixQuiz = 0;

  //Variable liste des difficultés du quiz
  List<String> difficulte = ['Facile','Moyen','Difficile'];

  //Variable de la selection de la drop down list
  var selected = null;

  //Méthode d'initialisation
  @override
  void initState(){
    super.initState();

    nomquiz = widget.nameQuiz;
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              leading: BackButton(
                color: Colors.black,
                onPressed:() => Navigator.of(context).pop() ,
              ),
              title: Text("Configuration du quiz"),
              backgroundColor: Colors.blueGrey[400],
              elevation: 0.0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 36.0),
                        child: NiceButton(
                          elevation: 10.0,
                          radius: 52.0,
                          width: MediaQuery.of(context).size.width*0.80,
                          text: 'Paramétrage du quiz',
                          background: Colors.blue.withOpacity(0.2),
                          fontSize: 20,
                        )
                    ),
                  ),
                  Text(''),
                  Text(''),
                  Text(''),
                  Text(''),
                  Container(
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.circular(10)),
                    child: new Theme(
                      data: Theme.of(context).copyWith(
                        canvasColor: Colors.white30,
                      ),
                    // dropdown below..
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownButton<String>(
                          hint: Text("Difficulté :"),
                            focusColor: Colors.white30,
                            value: selected,
                            isDense: true,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 42,
                            underline: SizedBox(),
                            onChanged: (String newValue) {
                              setState(() {
                                selected = newValue;
                              });
                            },
                            items: difficulte.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('Difficulté :          '+value),
                              );
                            }).toList())
                      ],
                    ),
                  )
                  ),
                  Text(''),
                  Text(''),
                  Text(''),
                  Card(
                    color: Colors.blue.withOpacity(0.2),
                    elevation: 10.0,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16.0),
                    ),
                    child: new Column(
                      children: <Widget>[
                        new ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: new Radius.circular(16.0),
                              topRight: new Radius.circular(16.0),
                            )
                        ),
                        new Padding(
                          padding: new EdgeInsets.all(16.0),
                          child: new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                  'Mode de jeu'
                                      ,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                      decoration:  TextDecoration.underline,
                                  )
                              ),
                              new Text(
                                  '                                                                           '
                                      'Dans ce mode tu devras répondre à six '
                                      'question, chaque réponse correcte te fait'
                                      ' gagner deux points et chaque réponse incorrecte'
                                      'te fait perdre un point',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0
                                  )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(''),
                  Text(''),
                  Text(''),
                  Text(''),
                  Align(
                    alignment: Alignment.center,
                    child: NiceButton(
                      elevation: 10.0,
                      radius: 52.0,
                      width: MediaQuery.of(context).size.width*0.80,
                      text: 'Commencer le quiz',
                      background: Colors.white70,
                      fontSize: 20,
                      onPressed:(){
                        if(selected == 'Facile')
                          {
                            level = '0';
                          }else if(selected == 'Moyen')
                            {
                              level = '1';
                            }else if(selected == 'Difficile')
                              {
                                level = '2';
                              }
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => optionTwo(nomquiz,score, pointPositif,pointNegatif, nbrPage, widget.idQuiz, level,choixQuiz),
                        ));
                      },
                    )
                  )
                ],
              ),
            ),
          ),
        )
    );
  }


}
