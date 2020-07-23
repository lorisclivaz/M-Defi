/*
 * Author : Loris Clivaz
 * Date creation : 14 juillet 2020
 */

import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/ClassementModel.dart';


/*
 * Classe de classement par score
 * @author Loris_Clivaz
 *
 * @link https://github.com/lorisclivaz/M-Defi.git
 */

class ClassementScore extends StatefulWidget {
  @override
  _ClassementScoreState createState() => _ClassementScoreState();
}

class _ClassementScoreState extends State<ClassementScore> with SingleTickerProviderStateMixin {

  //Animation
  AnimationController _animationController ;

  //Référence base  de données
  final fb = FirebaseDatabase.instance.reference().child("ClassementUsersThemes");
  final fbLangue = FirebaseDatabase.instance.reference().child("ClassementUsersLangues");


  //Place du joueur
  int place;

  //Listes où il y aura les données dedans
  List<ClassementModel> list = List();
  List<ClassementModel> listLangue = List();
  List<ClassementModel> listTotal = List();
  var number = new List<int>.generate(10000, (i) => i + 1);




  @override
  void initState() {
    // TODO: implement initState
    //lancement de l'animation
    _animationController = AnimationController(
        vsync: this,
            duration: Duration(milliseconds: 1000)
    );
    

    Timer(Duration(milliseconds: 200), () => _animationController.forward());
    _animationController.forward();
    super.initState();

    //Récupération des themes
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score'],
            value['NomQuiz']);

        list.add(classement);

      });
      if(mounted)
      {
        setState(() {

        });
      }
    });

    //Récupération des langues
    fbLangue.once().then((DataSnapshot snap) {
      var data = snap.value;
      listLangue.clear();
      data.forEach((key, value) {
        ClassementModel classement = new ClassementModel(
            key,
            value['CoinQuiz'],
            value['Email'],
            value['PointNegatif'],
            value['PointPositif'],
            value['Score'],
            value['NomQuiz']);

        listLangue.add(classement);

      });
      if(mounted)
      {
        setState(() {

        });
      }
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  @override
    Widget build(BuildContext context) {

    listTotal = [...listLangue,...list];

    //Trier la liste du plus petit au plus grand

      listTotal.sort((b,a) => a.score.compareTo(b.score));


      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/BackGroundImage.jpg"),fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,

            body: new ListView.builder(
              itemCount: listTotal.length,

              itemBuilder: (context,index){
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: Offset(-1,0),
                    end: Offset.zero
                  ).animate(_animationController),
                  child: FadeTransition(
                    opacity: _animationController,
                    child: new SizedBox(
                      width: 100.0,
                      height: 300.0,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            child: FittedBox(
                              child: Material(
                                color: Colors.white38,
                                elevation: 14.0,
                                borderRadius: BorderRadius.circular(24.0),
                                shadowColor: Colors.white30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(7.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            SizedBox(
                                              height:10,
                                              width: MediaQuery.of(context).size.width*0.15,
                                              child: Container(
                                                child:  RaisedButton(

                                                  child: Text(
                                                     "Place "+listTotal[index].nomQuiz+" :"+ number[index].toString(),
                                                    style: TextStyle(
                                                      fontSize: 3
                                                    ),
                                                  ),
                                                  color: Colors.black12,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(16.0))),
                                                  onPressed: () {},
                                                )

                                              ),
                                            ),
                                            SizedBox(height: 2,),

                                            SizedBox(
                                              height: 10,
                                              width: MediaQuery.of(context).size.width*0.15,
                                              child:  Wrap(
                                                spacing: 20,
                                                children: <Widget>[
                                                  Text(
                                                    "Score : "+listTotal[index].score.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 3.5,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),

                                                  Text(
                                                    "CoinQuiz : "+listTotal[index].coinQuiz.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 3.5,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],

                                              ),
                                            ),
                                            SizedBox(height: 5,),
                                            SizedBox(
                                              height: 12,
                                              width: MediaQuery.of(context).size.width*0.10,
                                              child:  Wrap(
                                                spacing: 10,
                                                children: <Widget>[
                                                  Text(
                                                    "Point + : "+listTotal[index].pointPositif.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 3.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Point - : "+listTotal[index].pointNegatif.toString(),
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 3.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: 3,
                                                width: MediaQuery.of(context).size.width*0.10,
                                              child:Text(
                                                listTotal[index].email.toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 3.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ) ,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
  }
}
