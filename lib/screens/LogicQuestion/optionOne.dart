/*
 * Author : Loris Clivaz
 * Date creation : 14 juin 2020
 */

import 'dart:math';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/questions.dart';
import 'package:mdefi/models/reponse.dart';
import 'package:mdefi/models/solutions.dart';
import 'package:mdefi/screens/LogicQuestion/optionTwo.dart';
import 'package:mdefi/screens/quiz/endQuiz.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:mdefi/utils/Draggable/dragBox.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer la logic du quiz vrai ou faux avec les différentes question
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class optionOne extends StatefulWidget {

  //Variable du quiz
  final String level;
  final int nbrPage;
  final int score;
  final String idQuiz;
  final int pointPositif;
  final int pointNegatif;
  final String nomQuiz;
  final int choixQuiz;

  //Constructeur
  const optionOne(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage, this.idQuiz, this.level,this.choixQuiz);

  @override
  _optionOneState createState() => _optionOneState();
}

class _optionOneState extends State<optionOne> {

  //Listes où il y aura les données dedans
  List<Question> list = List();
  List<ReponseQuestion> listReponse = List();
  List<ReponseQuestion> listReponseFinal = List();
  List<Solution> listSolutions = List();
  List<Solution> listSolutionsFinal = List();

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
  String solution1 = 'Réponse Correcte';
  String solution2 = 'Réponse incorrecte';
  String solutionFinal = '';
  Solution objet = null;
  String titel = '';
  String text = '';

  //Variable quiz
  String nomQuiz = '';
  int choixQuiz = 0;

  //Draggable
  String value = 'Drag here';
  bool drag = false;

  //Variable loading
  bool loading = false;


  //Methode permettant de supprimer le state en cours
  @protected
  @mustCallSuper
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    print("Dispose option one");
  }


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
        if (questions.idQuiz == widget.idQuiz && questions.pageType == '1' &&
            questions.level == widget.level) {
          list.add(questions);
        }
      });
      if(mounted)
        {
          setState(() {

          });
        }

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
      if(mounted)
      {
        setState(() {
          loading = false;
        });
      }
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
      if(mounted)
      {
        setState(() {

        });
      }
    });
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    //Condition quand la liste est rempli on set la variable aléatoire ainsi que le nom de la question
    if(mounted)
    {
      if (list.length > 0) {
        pointPositif = widget.pointPositif;
        pointNegatif = widget.pointNegatif;
        a = randomValue(list);
        name = list[a].name;
        nbrPage = widget.nbrPage + 1;
        level = widget.level;
        drag = true;
        idQuestion = list[a].id;
        listReponseFinal = reponseSet(listReponse, idQuestion);
        choixQuiz = widget.choixQuiz;
        //Si la liste contient des données, on ajoute les valeurs dans les variables
        if (listReponseFinal.length > 0) {
          reponse1 = listReponseFinal[0].name;
          reponse2 = listReponseFinal[1].name;
        }

        //On crée la nouvelle liste selon la condition
        objet = solutionsSet(listSolutions, idQuestion);

        //On ajoute les valeurs dans les variables
        text = objet.text;
        titel = objet.titel;
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
                                  Container(
                                    color: Colors.white30,
                                    // don't forget about height
                                    height: 200,
                                    child: draggable(context),
                                  )
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

//Méthode qui génère le design du drag and drop
  Widget draggable(BuildContext context) {
    if (drag == true) {
      return Stack(
        children: <Widget>[
          DragBox(Offset(50.0, 20.0), reponse1, Colors.white30),
          DragBox(Offset(50.0, 100.0), reponse2, Colors.white30),
          Positioned(
            right: 50.0,
            bottom: 50.0,
            child: DragTarget(
                onAccept: (String data) {
                  value = data;
                  if (value == reponseCorrect) {
                    solutionFinal = solution1;
                    pointPositif = pointPositif +2;
                  } else {
                    solutionFinal = solution2;
                    pointNegatif = pointNegatif -1;
                  }

                  //Génère un dialog box qui informe l'utilisateur si la réponse est correct ou pas
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white30,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(20.0)
                          ),
                          child: Container(
                            height: 300,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(solutionFinal,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 19.0,
                                        decoration: TextDecoration.underline,
                                      )),
                                  Text(''),
                                  Text(
                                      text,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0,
                                      )
                                  ),
                                  Text(''),
                                  SizedBox(
                                    width: 320.0,
                                    child: NiceButton(
                                      background: Colors.blue.withOpacity(0.5),
                                      elevation: 10.0,
                                      radius: 52.0,
                                      text: "Suivant",
                                      onPressed: () {
                                        if (nbrPage < 6) {
                                          if(choixQuiz <= 2)
                                            {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        optionOne(nomQuiz,score, pointPositif, pointNegatif, nbrPage,
                                                            widget.idQuiz, level,choixQuiz),
                                                  ));
                                              choixQuiz++;
                                            }else{
                                            Navigator.of(context).push(MaterialPageRoute(
                                              builder: (context) =>optionTwo(nomQuiz,score, pointPositif, pointNegatif, nbrPage,
                                                  widget.idQuiz, level,choixQuiz),
                                            ));
                                          }
                                        }
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                builder: (BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,) {
                  return Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.3,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.15,
                    decoration: BoxDecoration(
                      color: Colors.white30,
                    ),
                    child: Center(
                      child: Text(value),
                    ),
                  );
                }
            ),
          )
        ],
      );
    }
  }

  //Méthode qui récupère les informations sur la bonne solution
  Solution solutionsSet(List<Solution> list, String idQuestion) {
    Solution fake = new Solution('', '', '', '', '');

    for (var i in listSolutions) {

      if (i.idQuestion == idQuestion) {
        fake = new Solution(i.key, i.id, i.idQuestion, i.text, i.titel);
      }
    }
    return fake;
  }

  //Méthode qui va générer la liste des réponses
  List<ReponseQuestion> reponseSet(List<ReponseQuestion> list,
      String idQuestion) {
    List<ReponseQuestion> setReponse = List();

    for (var i in list) {
      if (i.idQuestion == idQuestion) {
        ReponseQuestion a = new ReponseQuestion(
            i.key, i.answer, i.id, i.idQuestion, i.image, i.name);
        setReponse.add(a);
        if (a.answer == '1') {
          reponseCorrect = a.name;
        }
      }
    }
    return setReponse;
  }


}