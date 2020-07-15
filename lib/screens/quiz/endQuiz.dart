/*
 * Author : Loris Clivaz
 * Date creation : 09 juin 2020
 */

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/ClassementModel.dart';
import 'package:mdefi/screens/home/homeApp.dart';
import 'package:mdefi/screens/quiz/CorrectionQuiz.dart';
import 'package:mdefi/screens/quiz/EndCorrectionQuizLangues.dart';
import 'package:mdefi/services/database.dart';
import 'package:nice_button/NiceButton.dart';

/*
 * Classe qui va afficher le résultat du quiz
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class endQuiz extends StatelessWidget {

  //Variables de la base de données
  final fbThemes = FirebaseDatabase.instance.reference().child("ClassementUsersThemes");
  final fbLangues = FirebaseDatabase.instance.reference().child("ClassementUsersLangues");

  //Variable pour le classement
  int isExist;
  int coinQuizUpdate, scoreScoreUpdate, pointNegatifUpdate, pointPositifUpdate;


  //Listes où il y aura les données dedans
  List<ClassementModel> list = List();
  List<ClassementModel> listLangues = List();


  //Variable du score et du nombre de pages
  int score;
  int pointPositif;
  int pointNegatif;
  int nbrPage;
  String nomQuiz;
  String petitePhrase = '';
  int coinQuiz = 0;

  //Variable pour la base de données
  Database db = new Database();

  //Constructeur
  endQuiz(this.nomQuiz,this.score, this.pointPositif, this.pointNegatif, this.nbrPage,this.petitePhrase);


  //Design de la page
  @override
  Widget build(BuildContext context) {

    if(score > 0)
      {
        coinQuiz = score * 3;
      }


    return MaterialApp(
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
                  Card(
                    margin: EdgeInsets.all(16.0),
                    borderOnForeground: true,
                    elevation: 10.0,
                    color: Colors.black.withOpacity(0.6),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(16.0),
                    ),
                    child: Wrap(
                      spacing: 60,
                      children: <Widget>[
                        Icon(Icons.attach_money, size: 30),
                        Text(
                          '$coinQuiz coinquiz',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                          ),
                        )
                      ],

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

                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                          HomeApp()), (Route<dynamic> route) => false);

                      db.DeleteCorrectionQuiz();

                      if(nomQuiz == 'Langues')
                        {
                          updateInformationClassementLangues();

                        }else
                          {
                            updateInformationClassementThemes();


                          }
                    },
                  ),
                  Text(""),

                  NiceButton(
                    elevation: 10.0,
                    radius: 52.0,
                    width: MediaQuery.of(context).size.width*0.80,
                    text: "Correction",
                    background: Colors.white70,
                    fontSize: 20,
                    onPressed:(){
                      //UpdateClassement classement

                      if(nomQuiz == 'Langues')
                        {
                          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                              EndCorrectionQuizLangues()), (Route<dynamic> route) => false);

                          updateInformationClassementLangues();

                        }else
                          {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                CorrectionQuiz()), (Route<dynamic> route) => false);

                            updateInformationClassementThemes();

                          }

                    },
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  //Modifier les informations de classement pour les themes
  void updateInformationClassementThemes() {

    //Récupération du classement langues
    fbThemes.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score']);

        print("Comparaison email : 1"+HomeApp.email + " email 2 "+classement.email);
        if(HomeApp.email == classement.email)
        {
          isExist = 1;
          coinQuizUpdate = coinQuiz + classement.coinQuiz;
          scoreScoreUpdate = score + classement.score;
          pointNegatifUpdate = pointNegatif + classement.pointNegatif;
          pointPositifUpdate = pointPositif + classement.pointPositif;

          db.updateClassementThemes(key, HomeApp.email, coinQuizUpdate, scoreScoreUpdate, pointNegatifUpdate, pointPositifUpdate);
        }
        list.add(classement);

      });

    });


  }

  //Modifier les informations pour les langues
  void updateInformationClassementLangues() {

    //Récupération du classement langues
    fbLangues.once().then((DataSnapshot snap) {
      var data = snap.value;
      listLangues.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score']);

        print("Comparaison email : 1"+HomeApp.email + " email 2 "+classement.email);
        if(HomeApp.email == classement.email)
        {
          isExist = 1;
          coinQuizUpdate = coinQuiz + classement.coinQuiz;
          scoreScoreUpdate = score + classement.score;
          pointNegatifUpdate = pointNegatif + classement.pointNegatif;
          pointPositifUpdate = pointPositif + classement.pointPositif;

          db.updateClassementLangues(key, HomeApp.email, coinQuizUpdate, scoreScoreUpdate, pointNegatifUpdate, pointPositifUpdate);
        }
        list.add(classement);

      });

    });


  }

}

