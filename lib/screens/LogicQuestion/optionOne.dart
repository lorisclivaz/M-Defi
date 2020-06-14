import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/questions.dart';
import 'package:mdefi/models/reponse.dart';
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
String value = 'Drag here';
  //List ou il y aura les données dedans
  List<Question> list = List();
  List<ReponseQuestion> listReponse = List();
  List<ReponseQuestion> listReponseFinal = List();

  final fb = FirebaseDatabase.instance.reference().child("question");
  final fb2 = FirebaseDatabase.instance.reference().child("response");



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

  //Draggable
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

        print("IdQuestion");
        print("871");
        idQuestion = '871';
        listReponseFinal = reponseSet(listReponse,idQuestion);
        reponse1 = listReponseFinal[0].name;
        reponse2 = listReponseFinal[1].name;
        print("Reponse correct : ");
        print(reponseCorrect);



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
                  height: 400,
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
                          height: 200,
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
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                Text(''),
                NiceButton(
                  elevation: 10.0,
                  radius: 52.0,
                  width: MediaQuery.of(context).size.width*0.80,
                  text: 'Question suivante',
                  background: Colors.white70,
                  fontSize: 20,
                  onPressed:(){
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

                )
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
                    print("Bien joué mec");
                  }else{
                  print("Tu es nul mec");
                }
              },
              builder: (
              BuildContext context,
                  List<dynamic> accepted,
                  List<dynamic> rejected,
              ){
                return Container(
                  width: 100.0,
                  height: 100.0,
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