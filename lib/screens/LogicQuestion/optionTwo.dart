/*
 * Author : Loris Clivaz
 * Date creation : 16 juin 2020
 */

import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/questions.dart';
import 'package:mdefi/models/reponse.dart';
import 'package:mdefi/models/solutions.dart';
import 'package:mdefi/screens/quiz/quizEnd.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:mdefi/utils/Draggable/dragBox.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer la logic du quiz réponse aléatoire
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class optionTwo extends StatefulWidget {

  //Variable du quiz
  final String level;
  final int nbrPage;
  final int score;
  final String idQuiz;
  final int pointPositif;
  final int pointNegatif;
  final String nomQuiz;

  //Constructeur
  const optionTwo(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage, this.idQuiz, this.level);

  @override
  _optionTwoState createState() => _optionTwoState();
}

class _optionTwoState extends State<optionTwo> {

  //Listes où il y aura les données dedans
  List<Question> list = List();
  List<ReponseQuestion> listReponse = List();
  List<ReponseQuestion> listReponseFinal = List();
  List<Solution> listSolutions = List();

  //Variables de la base de données
  final fb = FirebaseDatabase.instance.reference().child("question");
  final fb2 = FirebaseDatabase.instance.reference().child("response");
  final fb3 = FirebaseDatabase.instance.reference().child("solutions");


  //Variables valeur aléatoire
  Random rnd = new Random();
  int max;
  int min;
  int a;

  //Variable questions
  String name = '';
  int nbrPage = 0;
  int score = 0;
  int pointPositif = 0;
  int pointNegatif = 0;
  String level;


  //Variable réponse
  String idQuestion;
  String reponseCorrect;
  String reponse1 = '';
  String reponse2 = '';

  //Variable show solution
  bool _isVisible = false;
  String solution1 = 'Réponse Correcte';
  String solution2 = 'Réponse incorrecte';
  String solutionFinal = '';
  Solution objet = null;


  //Variable quiz
  String nomQuiz = '';

  //Draggable
  String value = 'Drag here';
  bool drag = false;

  //Variable loading
  bool loading = false;

  //Méthode d'initialisation des données
  void initState() {
    super.initState();
    loading = true;
    nomQuiz = widget.nomQuiz;

    //Récupération des questions
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();

      data.forEach((key, value) {
        Question questions = new Question(
            key,
            value['Id'],
            value['IdQuiz'],
            value['Image'],
            value['Level'],
            value['Name'],
            value['PageType']);
        if (questions.idQuiz == widget.idQuiz && questions.pageType == '2' &&
            questions.level == widget.level) {
          list.add(questions);
        }
      });
      setState(() {

      });
    });

    //Récupération des réponses
    fb2.once().then((DataSnapshot snap) {
      var data = snap.value;
      listReponse.clear();
      data.forEach((key, value) {
        ReponseQuestion reponses = new ReponseQuestion(
            key, value['Answer'], value['Id'], value['IdQuestion'],
            value['Image'], value['Name']);
        listReponse.add(reponses);
      });
      setState(() {
        loading = false;
      });
    });

    //Récupération des solutions
    fb3.once().then((DataSnapshot snap) {
      var data = snap.value;
      listSolutions.clear();
      data.forEach((key, value) {
        Solution solutions = new Solution(
            key, value['Id'], value['IdQuestion'], value['Text'],
            value['Titel']);
        listSolutions.add(solutions);
      });
      setState(() {});
    });
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    //Condition quand la liste est rempli on set la variable aléatoire ainsi que le nom de la question
    if (list.length > 0) {
      pointPositif = widget.pointPositif;
      pointNegatif = widget.pointNegatif;
      a = randomValue(list);
      name = list[a].name;
      nbrPage = widget.nbrPage + 1;
      level = widget.level;
      drag = true;
      idQuestion = list[a].id;

      //Si la liste contient des données, on ajoute les valeurs dans les variables
      if (listReponseFinal.length > 0) {
        reponse1 = listReponseFinal[0].name;
        reponse2 = listReponseFinal[1].name;
      }
    }

    //Design de la page
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
              elevation: 0.0,
              title: Text('Quiz'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: () => print("annulation du quiz"),
                ),
              ],
              leading: new Container(),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.9,
                    child: Card(
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
                                    'Question $nbrPage'
                                    ,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                      decoration: TextDecoration.underline,
                                    )
                                ),

                                new Text(
                                    name,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18.0
                                    )
                                ),
                              ],
                            ),
                          ),

                          Container(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.40,
                              child: Column(
                                children: <Widget>[

                                ],
                              )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  //Methode permettant de selectionner une valeur aléatoire par rapport à la taille de la liste des questions
  int randomValue(List<Question> questions) {
    min = 0;
    max = list.length;
    a = Random().nextInt(list.length);
    return a;
  }






}