import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/questions.dart';
import 'package:mdefi/models/reponse.dart';
import 'package:mdefi/models/solutions.dart';
import 'package:mdefi/screens/quiz/quizEnd.dart';
import 'package:mdefi/utils/Draggable/dragBox.dart';
import 'package:nice_button/NiceButton.dart';

class optionOne extends StatefulWidget {

  final String level;
  final int nbrPage;
  final int score;
  final String idQuiz;

  const optionOne(this.score, this.nbrPage, this.idQuiz, this.level);

  @override
  _optionOneState createState() => _optionOneState();
}

class _optionOneState extends State<optionOne> {

  //Widget
  Widget _CorrectReponse;

  //List ou il y aura les données dedans
  List<Question> list = List();
  List<ReponseQuestion> listReponse = List();
  List<ReponseQuestion> listReponseFinal = List();
  List<Solution> listSolutions = List();
  List<Solution> listSolutionsFinal = List();

  final fb = FirebaseDatabase.instance.reference().child("question");
  final fb2 = FirebaseDatabase.instance.reference().child("response");
  final fb3 = FirebaseDatabase.instance.reference().child("solutions");




//Valeur aléatoire
  Random rnd = new Random();
  int max;
  int min;
  int a;

  //Variable questions
  String name = '';
  int nbrPage = 0;
  int score = 0;
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
  String titel = '';
  String text = '';

  //Draggable
  String value = 'Drag here';
  bool drag = false;




  void initState(){
    super.initState();

    //Récupération des questions
    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();

      data.forEach((key,value){
        Question questions = new Question(key, value['Id'], value['IdQuiz'], value['Image'], value['Level'], value['Name'],value['PageType']);

        if(questions.idQuiz == widget.idQuiz && questions.pageType == '1' && questions.level == widget.level)
          {
            list.add(questions);
          }


      });
      setState(() {

      });

    });

    //Récupération des réponses
    fb2.once().then((DataSnapshot snap){
      var data = snap.value;
      listReponse.clear();

      data.forEach((key,value){
        ReponseQuestion reponses = new ReponseQuestion(key, value['Answer'], value['Id'], value['IdQuestion'], value['Image'], value['Name']);

        listReponse.add(reponses);

      });
      setState(() {

      });

    });

    //Récupération les solutions
    fb3.once().then((DataSnapshot snap){
      var data = snap.value;
      listSolutions.clear();

      data.forEach((key,value){
        Solution solutions = new Solution(key, value['Id'], value['IdQuestion'], value['Text'], value['Titel']);

        listSolutions.add(solutions);



      });
      setState(() {

      });

    });


  }


  @override
  Widget build(BuildContext context) {
    //Condition quand la liste est rempli on set la variable aléatoire ainsi que le nom de la question
    if(list.length > 0)
      {
        a = randomValue(list);
        name = list[a].name;
        nbrPage = widget.nbrPage + 1 ;
        level = widget.level;
        drag = true;


        idQuestion = list[a].id;
        listReponseFinal = reponseSet(listReponse,idQuestion);

        if(listReponseFinal.length > 0)
        {
          reponse1 = listReponseFinal[0].name;
          reponse2 = listReponseFinal[1].name;
        }

        objet = solutionsSet(listSolutions, idQuestion);

        text = objet.text;
        titel = objet.titel;




      }


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
                  height: MediaQuery.of(context).size.width*1.25,
                  child:  Card(
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
                                    decoration:  TextDecoration.underline,
                                  )
                              ),

                              new Text(
                                  name ,
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
                          height: MediaQuery.of(context).size.height*0.40,
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
  int randomValue (List<Question> questions){
    min = 0;
    max = list.length;
    a = Random().nextInt(list.length);
    return a;

}

Widget draggable(BuildContext context)
{


  if(drag == true)
    {
      return Stack(
        children: <Widget>[
          DragBox(Offset(50.0,20.0), reponse1, Colors.white30),
          DragBox(Offset(50.0,100.0), reponse2, Colors.white30),
          Positioned(
            right: 50.0,
            bottom: 50.0,
            child: DragTarget(
              onAccept: (String data){
                value = data;

                if(value == reponseCorrect)
                  {
                    solutionFinal = solution1;

                    print("Bien joué mec");
                  }else{
                  solutionFinal = solution2;

                  print("Tu es nul mec");
                }

                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(

                        backgroundColor: Colors.white30,
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
                                Text(solutionFinal,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 19.0,
                                      decoration:  TextDecoration.underline,
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
                                      if(nbrPage < 6)
                                      {

                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => optionOne(score, nbrPage, widget.idQuiz, level),
                                        ));
                                      }else
                                      {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => QuizEnd(score, nbrPage),
                                        ));

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
              builder: (
              BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
              ){
                return Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  height: MediaQuery.of(context).size.height*0.15,
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
  Solution solutionsSet(List<Solution> list, String idQuestion)
  {
    Solution fake = new Solution('', '', '', '', '');


    for ( var i in listSolutions )
    {
      print(idQuestion);
      print(i.idQuestion);
      if(i.idQuestion == idQuestion)
      {
        fake = new Solution(i.key, i.id, i.idQuestion, i.text,i.titel);

      }


    }

    return fake;

  }

  List<ReponseQuestion> reponseSet(List<ReponseQuestion> list, String idQuestion)
  {
    List<ReponseQuestion> setReponse = List();

    for ( var i in list )
    {
      if(i.idQuestion == idQuestion)
      {
        ReponseQuestion a = new ReponseQuestion(i.key, i.answer, i.id, i.idQuestion, i.image, i.name);
        setReponse.add(a);

        if(a.answer == '1')
        {
          reponseCorrect = a.name;
        }
      }


    }
    return setReponse;

  }

Widget solution(BuildContext context)
{
  return Visibility(
    visible: _isVisible,
    child: Container(
      alignment: Alignment.center,

      child:  Card(

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
                      solutionFinal
                      ,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        decoration:  TextDecoration.underline,
                      )
                  ),

                  new Text(
                      titel + ' : '+ text ,
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

    ),
  );
}
  void _toggle(){
    setState(() {
      _isVisible = !_isVisible;
    });
  }
}
/*
AppBar(
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
 */