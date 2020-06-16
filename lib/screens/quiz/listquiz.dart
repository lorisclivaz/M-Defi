/*
 * Author : Loris Clivaz
 * Date creation : 09 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/quiz.dart';
import 'package:mdefi/screens/QuestionPage/questionPage.dart';
import 'package:mdefi/shared/loading.dart';

/*
 * Classe qui va gérer la list de quiz par thème
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */
class QuizList extends StatefulWidget {

  //Variable du thème
  final String idTheme;

  //Constructeur
  const QuizList(this.idTheme);

  @override
  _listQuizState createState() => _listQuizState();
}

class _listQuizState extends State<QuizList> {

  //Variable de la base de données
  final fb = FirebaseDatabase.instance.reference().child("quiz");


  //Variable de la liste ou il y aura les données des différents quiz
  List<Quiz> list = List();

  //Variable du loading
  bool loading = false;

  //Methode dînitialisation qui au moment du loading de la page, les données se mettent dans la liste
  @override
  void initState(){
    super.initState();
    loading = true;

    //Méthode qui permet d'ajouter tous les quiz par rapport au thème dans la liste
    fb.once().then((DataSnapshot snap){
      var data = snap.value;
      list.clear();
      data.forEach((key,value){
        Quiz quizs = new Quiz(key, value['Id'], value['Name'], value['IdTheme']);
        if(quizs.idTheme == widget.idTheme)
          {
            list.add(quizs);
          }
      });
      setState(() {
        loading = false;
      });
    });
  }

  //Design de la page
  @override
  Widget build(BuildContext context) {
    return  loading ? Loading() :MaterialApp(
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
              title: Text("Quiz"),
              backgroundColor: Colors.blueGrey[400],
              elevation: 0.0,
            ),
            body:new ListView.builder(
              itemCount: list.length,
              itemBuilder: (context,index){
                return new SizedBox(
                  width: 100.0,
                  height: 120.0,
                  child: Container(
                    padding: EdgeInsets.only(bottom:30.0,left: 20,right: 20,top: 25),
                    child: ui(index),
                  ),
                );
              },
            ),
          ),
        )
    );
  }

  //Méthode qui retourne le design des boxy avec les informations à l'intérieur
  Widget ui(int index){
    return GestureDetector(
      onTap: (){
        print(list[index].id);
        print(list[index].name);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => QuestionPage(list[index].id, list[index].name),
        ));
      },
      child: new Card(
        elevation: 10.0,
        color: Colors.white30,
          shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(16.0),
        ),
        child: new Column(
          children: <Widget>[
            new ClipRRect(
                child: new Image.network(list[index].name),
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
                    list[index].name.toUpperCase(),
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
