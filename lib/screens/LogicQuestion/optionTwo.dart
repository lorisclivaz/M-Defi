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
import 'package:mdefi/screens/LogicQuestion/optionOne.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/screens/quiz/endQuiz.dart';
import 'package:mdefi/services/database.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:mdefi/utils/dropDown/dropDown.dart';
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
  final int choixQuiz;


  //Constructeur
  const optionTwo(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage, this.idQuiz, this.level,this.choixQuiz);

  @override
  _optionTwoState createState() => _optionTwoState();
}

class _optionTwoState extends State<optionTwo> {

  //Listes où il y aura les données dedans
  List<Question> list = List();

  List<Solution> listSolutions = List();

  //Variables de la base de données
  final fb = FirebaseDatabase.instance.reference().child("question");
  final fb2 = FirebaseDatabase.instance.reference().child("response");
  final fb3 = FirebaseDatabase.instance.reference().child("solutions");

  Database db = new Database();
  String reponseCorrection = null;
  int userAnswer;


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
  int choixQuiz = 0;
  String text = '';
  String petitePhrase;



  //Variable loading
  bool loading = false;

  //Variable dropDown list
  List<ReponseQuestion> reponse = List();
  List<ReponseQuestion> reponseFinal = List();
  dropDown valueAnswer;
  String test = '';



  //Méthode permettant de supprimer le state en cours
  @protected
  @mustCallSuper
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose option two");

  }

  @override
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
          if(mounted)
          {
            setState(() {

            });
          }
        });

        //Récupération des réponses
        fb2.once().then((DataSnapshot snap) {
          var data = snap.value;
          reponse.clear();
          data.forEach((key, value) {
            ReponseQuestion reponses = new ReponseQuestion(
                key, value['Answer'], value['Id'], value['IdQuestion'],
                value['Image'], value['Name']);
            reponse.add(reponses);
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
    if(mounted)
      {
        //Condition quand la liste est rempli on set la variable aléatoire ainsi que le nom de la question
        if (list.length > 0) {
          pointPositif = widget.pointPositif;
          pointNegatif = widget.pointNegatif;
          a = randomValue(list);
          name = list[a].name;
          nbrPage = widget.nbrPage + 1;
          level = widget.level;
          idQuestion = list[a].id;
          choixQuiz = widget.choixQuiz;
        }

        if(reponse.length > 0)
        {
          reponseFinal = setReponseFinale(reponse, idQuestion);
        }

        if(reponseFinal.length > 0)
        {
          valueAnswer = new dropDown(reponseFinal);
        }

        if(listSolutions.length > 0)
        {
          //On crée la nouvelle liste selon la condition
          objet = solutionsSet(listSolutions, idQuestion);

          //On ajoute les valeurs dans les variables
          text = objet.text;
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
              centerTitle: true,
              backgroundColor: Colors.blueGrey[400],
              elevation: 0.0,
              title: Text('Quiz'),
              actions: <Widget>[
                new IconButton(
                  icon: new Icon(Icons.close),
                  onPressed: (){
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius.circular(20.0)), //this right here
                            child: Container(
                              height: 200,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: 'Aucune sauvegarde de quiz'),
                                    ),
                                    SizedBox(
                                      width: 320.0,
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                              HomeApp()), (Route<dynamic> route) => false);

                                          db.DeleteCorrectionQuiz();
                                        },
                                        child: Text(
                                          "Page d'accueil",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        color: Colors.black45,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  },
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
                      elevation: 8.0,
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
                              child: valueAnswer
                          ),
                          Text(''),
                          Text(''),
                          Text(''),
                          NiceButton(
                            elevation: 10.0,
                            radius: 52.0,
                            width: MediaQuery.of(context).size.width*0.80,
                            text: 'Confirmer la réponse',
                            background: Colors.white70,
                            fontSize: 20,
                            onPressed:(){
                              print(valueAnswer.getAnswer());
                              if(valueAnswer.getAnswer() == '1')
                              {
                              solutionFinal='Réponse correct';
                              pointPositif = pointPositif+2;
                              userAnswer = 0;
                              }else
                              {
                              solutionFinal = 'Réponse incorrect';
                              pointNegatif = pointNegatif -1;
                              userAnswer = 1;
                              }
                              if (nbrPage < 6) {
                                if (choixQuiz < 3) {
                                  choixQuiz++;
                                  Navigator.of(context)
                                      .push(
                                      MaterialPageRoute(
                                        builder: (
                                            context) =>
                                            optionTwo(
                                                nomQuiz,
                                                score,
                                                pointPositif,
                                                pointNegatif,
                                                nbrPage,
                                                widget
                                                    .idQuiz,
                                                level,
                                                choixQuiz),
                                      ));
                                  db.insertCorrectionQuestion(nomQuiz, nbrPage, name, reponseCorrection, userAnswer);
                                } else {
                                  Navigator.of(context)
                                      .push(
                                      MaterialPageRoute(
                                        builder: (
                                            context) =>
                                            optionOne(
                                                nomQuiz,
                                                score,
                                                pointPositif,
                                                pointNegatif,
                                                nbrPage,
                                                widget
                                                    .idQuiz,
                                                level,
                                                choixQuiz),

                                      ));
                                  db.insertCorrectionQuestion(nomQuiz, nbrPage, name, reponseCorrection, userAnswer);

                                }
                              } else {
                                score = pointPositif + pointNegatif;
                                if(score > 6)
                                {
                                  petitePhrase = 'Bonne performance !!!!';
                                }else
                                {
                                  petitePhrase = 'Mauvaise performance !!!!';
                                }
                                nomQuiz = 'Thèmes';

                                Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          endQuiz(nomQuiz,score, pointPositif,pointNegatif, nbrPage,petitePhrase),
                                    ));
                                db.insertCorrectionQuestion(nomQuiz, nbrPage, name, reponseCorrection, userAnswer);

                              }
                            },
                          )
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


  //Methode qui permet de récupérer les choix de réponse par rapport à la question
  List<ReponseQuestion> setReponseFinale(List<ReponseQuestion> reponse, String idQuestion)
  {
    List<ReponseQuestion> setReponse = List();

if(reponse == null)
  {
    setReponse.add(new ReponseQuestion('', '', '', '', '', '' ));
  }
    for (var i in reponse) {
      if (i.idQuestion == idQuestion) {
        ReponseQuestion a = new ReponseQuestion(
            i.key, i.answer, i.id, i.idQuestion, i.image, i.name);
        setReponse.add(a);
        if (a.answer == '1') {
          reponseCorrect = a.name;
          reponseCorrection = a.name;
        }
      }
    }

    return setReponse;
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

}