/*
 * Author : Loris Clivaz
 * Date creation : 08 juillet 2020
 */

import 'dart:async';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/questionLangue.dart';
import 'package:mdefi/models/reponseLangues.dart';
import 'package:mdefi/screens/quiz/endQuiz.dart';
import 'package:mdefi/shared/loading.dart';
import 'package:mdefi/utils/dropDown/dropDown.dart';
import 'package:mdefi/utils/dropDown/dropDownLangue.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va gérer la logic du quiz avec les différentes question
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class optionLangueOne extends StatefulWidget {

  //Variable du quiz
  final String level;
  final int nbrPage;
  final int score;
  final int pointPositif;
  final int pointNegatif;
  final String langue;
  final int choixQuiz;

  const optionLangueOne(this.level, this.nbrPage, this.score, this.pointPositif, this.pointNegatif, this.langue, this.choixQuiz);



  @override
  _optionLangueOneState createState() => _optionLangueOneState();
}

class _optionLangueOneState extends State<optionLangueOne> {

  //Variables de la base de données
  final fb = FirebaseDatabase.instance.reference().child("question_langues");
  final fb2 = FirebaseDatabase.instance.reference().child("response_langues");


  //Les listes
  List<QuestionLangue> list = List();
  List<ReponseLangue> listReponse = List();
  List<ReponseLangue> listReponseFinal = List();




  //Variables valeur aléatoire
  Random rnd = new Random();
  int max;
  int min;
  int a;

  //Variable questions
  String name1;
  String name2;
  String langue;
  int nbrPage = 0;
  int score = 0;
  int pointPositif = 0;
  int pointNegatif = 0;
  String level;

  //Variable quiz
  int choixQuiz = 0;
  String nomQuiz = "Langues";
  String petitePhrase;

  //Variable loading
  bool loading = false;

  //DropDown list
  dropDownLangue valueAnswer;




  //Methode permettant de supprimer le state en cours
  @protected
  @mustCallSuper
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("Dispose option one langue");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loading = true;
    langue = widget.langue;
    print("La derniere langue = à :"+ widget.langue);


//Récupération des questions
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();

      data.forEach((key, value) {
        QuestionLangue questions = new QuestionLangue(
            key,
            value['Id'],
            value['Indice'],
            value['Level'],
            value['Name1'],
            value['Name2'],
            value['PageType'],
            value['RuleId'],
            value['langue'],);
        print('Level : '+widget.level);
        print('langue:' +widget.langue);

        if(questions.level == widget.level && questions.Langue == widget.langue )
          {
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
        ReponseLangue reponses = new ReponseLangue(
            key, value['Answer'], value['Id'], value['IsGoodAnswer'],
            value['questionId']);
        listReponse.add(reponses);
      });
      if(mounted)
      {
        setState(() {

          loading = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    if(list.length >0)
      {
        pointPositif = widget.pointPositif;
        pointNegatif = widget.pointNegatif;
        a = randomValue(list);
        nbrPage = widget.nbrPage + 1;
        level = widget.level;
        name1 = list[a].name1;
        name2 = list[a].name2;

        listReponseFinal = reponseSet(listReponse,list[a].id);

        valueAnswer = new dropDownLangue(listReponseFinal);

      }
    return  loading ? Loading() : MaterialApp(
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

                                new Text(''),

                                new Container(
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                          name1,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0
                                          )
                                      ),
                                      valueAnswer,
                                      Text(
                                          name2,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18.0
                                          )
                                      ),
                                    ],

                                  )
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
                              onPressed: (){
                                if(valueAnswer.getAnswer() == '1')
                                  {
                                    pointPositif = pointPositif+2;
                                  }else{
                                  pointNegatif = pointNegatif -1;

                                }

                                if (nbrPage < 6) {
                                  if (choixQuiz < 3) {
                                    choixQuiz++;
                                    Navigator.of(context)
                                        .push(
                                        MaterialPageRoute(
                                          builder: (
                                              context) =>
                                              optionLangueOne(level,nbrPage, score, pointPositif, pointNegatif, langue, choixQuiz),
                                        ));
                                  } else {
                                    //faire la classe option deux
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
                                  Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            endQuiz(nomQuiz,score, pointPositif,pointNegatif, nbrPage,petitePhrase),
                                      ));
                                }
                              },
                            ),


                              ],

                            ),
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
  int randomValue(List<QuestionLangue> questions) {
    min = 0;
    max = list.length;
    a = Random().nextInt(list.length);
    return a;
  }

  //Méthode qui va générer la liste des réponses
  List<ReponseLangue> reponseSet(List<ReponseLangue> list,
      String idQuestion) {
    List<ReponseLangue> setReponse = List();

    for (var i in list) {
      if (i.questionId == idQuestion) {
        ReponseLangue a = new ReponseLangue(
            i.key, i.answer, i.id, i.isGoodAnswer, i.questionId);
        setReponse.add(a);
      }
    }
    return setReponse;
  }
}
