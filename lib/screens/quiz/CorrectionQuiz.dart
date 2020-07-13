import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mdefi/models/CorrectionQuiz.dart';

class CorrectionQuiz extends StatefulWidget {


  @override
  _CorrectionQuizState createState() => _CorrectionQuizState();
}

class _CorrectionQuizState extends State<CorrectionQuiz> {

  //Référence base  de données
  final fb = FirebaseDatabase.instance.reference().child("CorrectionQuiz");

  //Listes où il y aura les données dedans
  List<CorrectionQuizModel> list = List();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //Récupération de la correction des questions
    fb.once().then((DataSnapshot snap) {
      var data = snap.value;
      list.clear();
      data.forEach((key, value) {
        CorrectionQuizModel correctionQuizModel = new CorrectionQuizModel(
            key,
            value['NomQuiz'],
            value['NombrePage'],
            value['Question'],
            value['Reponse'],
            value['ReponseUser']);

        list.add(correctionQuizModel);

      });
      if(mounted)
      {
        setState(() {

        });
      }
    });


  }



  @override
  Widget build(BuildContext context) {


    return MaterialApp(
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
          body: new ListView.builder(
            itemCount: list.length,
            itemBuilder: (context,index){

              return new SizedBox(
                width: 100.0,
                height: 320.0,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      child: FittedBox(
                        child: Material(
                          color: Colors.white,
                          elevation: 14.0,
                          borderRadius: BorderRadius.circular(24.0),
                          shadowColor: Colors.white30,
                          child: Row(
                            children: <Widget>[
                              Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text("Question ")
                                ),

                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                  )
                ),
              );
            },
          ),
        ),
      ),


    );
  }



}
